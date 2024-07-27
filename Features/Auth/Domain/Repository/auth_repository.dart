import 'package:ecommerce_app/Features/Auth/data/auth_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../Core/Entities/user.dart';

class AuthRepository{
  final AuthRemoteDataSourceImpl impl;

  AuthRepository({required this.impl});

  Future<Either<String,bool>> googleSignIn()
  async {
    try{
      final userCredential=await impl.signInWithGoogle();
       User? user;

      if(userCredential!=null) {
         user=userCredential.user;
      }
      if(user!=null){
         List<String> fullName=[];
        if(user.displayName!=null) {
          fullName=UserModel.nameSeparator(user.displayName!);
        }
        UserModel newUser=UserModel(user.uid, firstName:fullName.isEmpty?'':fullName[0] , lastName:fullName.isEmpty?'':fullName.length>1?'':fullName[1], email: user.email??'', userName: "${fullName.isEmpty?'':fullName[0]}123", phoneNumber: user.phoneNumber??'', profilePicture: user.photoURL??'');
        await impl.addUser(newUser);
      }
      return const Right(true);
    }
    catch(e){
      return Left(e.toString());
    }
  }
  Future<Either<String,bool>> emailVerification()
  async {
    try{
      await impl.emailVerification();
      return const Right(true);
    }
    catch(e){
      return Left(e.toString());
    }
  }
  Future<Either<String,UserModel>> authenticateUser(String email, String password, String firstName, String phone, String lastName, String userName)
  async {
    try{
      final userId=  await impl.authenticateUser(email, password);
      final UserModel user=UserModel(userId.user!.uid,firstName: firstName, lastName: lastName, email: email, userName: userName, phoneNumber: phone, password: password, profilePicture: '',);
      await impl.addUser(user);

      return Right(user);
    }
    catch(e){
      return Left(e.toString());
    }
  }
  Future<Either<String,String>> checkIfFirstTime()
  async {
    try{
      return Right(await impl.checkIfFirstTime());
    }
        catch(e)
        {
          return Left(e.toString());
        }
  }
  Future<Either<String,bool>> signIn(String email,String password)
  async {
    try{
      await impl.signIn(email, password);
       return const Right(true);
  }
  catch(e)
    {
    return Left(e.toString());
    }
  }
}