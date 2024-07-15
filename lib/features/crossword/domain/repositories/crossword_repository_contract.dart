import 'package:crossworduel/core/exception/exception2either.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_finish_entity.dart';
import 'package:crossworduel/features/crossword/domain/usecases/finish_crossword_usecase.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crossword_leaders_usecase.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crossword_usecase.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crosswords_usecase.dart';
import 'package:crossworduel/features/crossword/domain/usecases/set_rating_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CrosswordRepositoryContract {
  Future<Either<ExceptionData, List<CrosswordEntity>>> getCrosswords(
      GetCrosswordsParams params);

  Future<Either<ExceptionData, CrosswordEntity>> getCrossword(
      GetCrosswordParams params);

  Future<Either<ExceptionData, CrosswordEntity>> setRating(
      SetRatingParams params);

  Future<Either<ExceptionData, None>> finishCrossword(
      FinishCrosswordParams params);

  Future<Either<ExceptionData, List<CrosswordFinishEntity>>>
      getCrosswordLeaders(GetCrosswordLeadersParams params);
}

class CrosswordRepositoryImpl implements CrosswordRepositoryContract {
  final SupabaseClient supabaseClient;

  CrosswordRepositoryImpl({required this.supabaseClient});

  @override
  Future<Either<ExceptionData, List<CrosswordEntity>>> getCrosswords(
          GetCrosswordsParams params) async =>
      exception2either<List<CrosswordEntity>>(function: () async {
        final List<Map<String, dynamic>> rawList;

        if (params.type.name == CrosswordsTypEnum.Profile.name) {
          rawList = await supabaseClient
              .from('normalized_crosswords_view')
              .select()
              .eq("user_id", params.userId!);
        } else {
          rawList = await supabaseClient
              .from('normalized_crosswords_view')
              .select()
              .eq("language", params.filterEntity.language)
              .eq("difficulty", params.filterEntity.difficulty);
        }

        List<CrosswordEntity> crosswrods = CrosswordEntity.parseList(rawList);
        return crosswrods;
      });

  @override
  Future<Either<ExceptionData, CrosswordEntity>> setRating(
          SetRatingParams params) async =>
      exception2either<CrosswordEntity>(function: () async {
        await supabaseClient
            .from('crossword_rating')
            .upsert({"id": params.crosswordId, "star": params.star});

        final Map<String, dynamic> rawItem = await supabaseClient
            .from('normalized_crosswords_view')
            .select()
            .eq("id", params.crosswordId)
            .single();

        CrosswordEntity result = CrosswordEntity.fromJson(rawItem);
        return result;
      });

  @override
  Future<Either<ExceptionData, None>> finishCrossword(
          FinishCrosswordParams params) async =>
      exception2either<None>(function: () async {
        await supabaseClient.from('crossword_finish').upsert(params.getBody());
        return None();
      });

  @override
  Future<Either<ExceptionData, List<CrosswordFinishEntity>>>
      getCrosswordLeaders(GetCrosswordLeadersParams params) async =>
          exception2either<List<CrosswordFinishEntity>>(function: () async {
            final List<Map<String, dynamic>> rawList = await supabaseClient
                .from('normalized_crossword_finish_view')
                .select()
                .eq("id", params.crosswordId);
            List<CrosswordFinishEntity> crosswrods =
                CrosswordFinishEntity.parseList(rawList);
            return crosswrods;
          });

  @override
  Future<Either<ExceptionData, CrosswordEntity>> getCrossword(
          GetCrosswordParams params) async =>
      exception2either<CrosswordEntity>(function: () async {
        final Map<String, dynamic> rawItem = await supabaseClient
            .from('normalized_crosswords_view')
            .select()
            .eq("id", params.crosswordId)
            .single();
        CrosswordEntity crosswrod = CrosswordEntity.fromJson(rawItem);
        return crosswrod;
      });
}
