abstract class UseCase<kType, kParams> {

  Future<kType> call({kParams params});
}