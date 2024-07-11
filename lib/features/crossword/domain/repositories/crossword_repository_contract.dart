import 'package:crossworduel/core/exception/exception2either.dart';
import 'package:crossworduel/features/crossword/domain/entities/crossword_entity.dart';
import 'package:crossworduel/features/crossword/domain/usecases/get_crosswords_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:crossworduel/core/exception/parent_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CrosswordRepositoryContract {
  Future<Either<ExceptionData, List<CrosswordEntity>>> getCrosswords(
      GetCrosswordParams params);
}

class CrosswordRepositoryImpl implements CrosswordRepositoryContract {
  final SupabaseClient supabaseClient;

  CrosswordRepositoryImpl({required this.supabaseClient});

  @override
  Future<Either<ExceptionData, List<CrosswordEntity>>> getCrosswords(
          GetCrosswordParams params) async =>
      exception2either<List<CrosswordEntity>>(function: () async {
        final List<Map<String, dynamic>> rawList =
            await supabaseClient.from('crosswords').select();
        List<CrosswordEntity> crosswrods = CrosswordEntity.parseList(rawList);
        return crosswrods;
      });
}
