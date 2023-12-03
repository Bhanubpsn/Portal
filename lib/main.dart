import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:restro_portal/AdminPortal/Homepage.dart';
import 'package:restro_portal/siginUp/Register.dart';
import 'RestroPortal/Homepage/homepage.dart';
import 'firebase_options.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: AuthCheck(),
  ));
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {

  @override
  void initState() {
    // TODO: implement initState
    initializeApp();

    super.initState();
  }

  Future<void> initializeApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      // User is authenticated, navigate to Dashboard
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Homepage(),
        ),
      );
    } else {
      // User is not authenticated, navigate to Intro
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginSignUp(),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}



class LoginSignUp extends StatefulWidget {
  const LoginSignUp({super.key});

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Thaiseva - RestroPortal",
          style: TextStyle(
            fontFamily: 'JosefinSans',
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignUp()));
                } ,
                child: Text(
                  "SignUp",
                  style: TextStyle(
                    fontFamily: 'JosefinSans'
                  ),
                )
            ),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogIn()));
                } ,
                child: Text(
                  "LogIn",
                  style: TextStyle(
                      fontFamily: 'JosefinSans'
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}


class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Thaiseva - RestroPortal",
          style: TextStyle(
            fontFamily: 'JosefinSans',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Welcome Back to Thaiseva",
            style: TextStyle(
              fontFamily: "JosefinSans",
              fontSize: 25,
            ),
          ),

          Column(
            children: [
              textFieldEmail(emailController),
              textfieldPassword(passwordController),
            ],
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(16.0)
            ),
            onPressed: () {
              if(emailController.text == 'admin@thaiseva' && passwordController.text == '1234567890'){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                  AdminHomepage()
                ));
              }
              else{
                signUserIn(emailController.text, passwordController.text,context);
                emailController.clear();
                passwordController.clear();
              }
            },
            child: const Text(
              "Continue",
              style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget textfieldPassword(TextEditingController controller)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        obscureText: true,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color(0xFFED1C24),
            ),
          ),
          prefixIcon: Icon(Icons.password, color: Colors.grey.shade600),
          alignLabelWithHint: true,
          labelText: "Password",
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget textFieldEmail(TextEditingController controller)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color(0xFFED1C24),
            ),
          ),
          prefixIcon: Icon(Icons.alternate_email, color: Colors.grey.shade600),
          alignLabelWithHint: true,
          labelText: "Email address",
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
          hintText: "eg. abc123@gmail.com",
        ),
      ),
    );
  }

}







class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Thaiseva - RestroPortal",
          style: TextStyle(
            fontFamily: 'JosefinSans',
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Welcome to Thaiseva",
            style: TextStyle(
              fontFamily: "JosefinSans",
              fontSize: 25,
            ),
          ),

          Column(
           children: [
             textFieldEmail(emailController),
             textfieldPassword(passwordController),
           ],
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.all(16.0)
            ),
            onPressed: () {
              registerUser(context, emailController.text, passwordController.text);
              emailController.clear();
              passwordController.clear();
            },
            child: const Text(
              "Continue",
              style: TextStyle(
                fontSize: 19.0,
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget textfieldPassword(TextEditingController controller)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        obscureText: true,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color(0xFFED1C24),
            ),
          ),
          prefixIcon: Icon(Icons.password, color: Colors.grey.shade600),
          alignLabelWithHint: true,
          labelText: "Password",
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget textFieldEmail(TextEditingController controller)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1.5,
              color: Color(0xFFED1C24),
            ),
          ),
          prefixIcon: Icon(Icons.alternate_email, color: Colors.grey.shade600),
          alignLabelWithHint: true,
          labelText: "Email address",
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.bold,
          ),
          hintText: "eg. abc123@gmail.com",
        ),
      ),
    );
  }




}
