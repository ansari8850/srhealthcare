import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:srhealthcare/constant/color_constant.dart';
import 'package:srhealthcare/constant/text_constant.dart';
import 'package:srhealthcare/customWidgets/custom_text.dart';
import 'package:srhealthcare/customWidgets/custom_text_filed.dart';
import 'package:srhealthcare/pages/authPage/bloc/login_bloc.dart';
import 'package:srhealthcare/pages/authPage/bloc/login_event.dart';
import 'package:srhealthcare/pages/authPage/bloc/login_state.dart';
import 'package:srhealthcare/pages/authPage/forget_password.dart';
import 'package:srhealthcare/pages/bottomNavigation/bottom_navigation.dart';
import 'package:srhealthcare/services/authApiService/login_api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(LoginApiService()),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: whiteColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ListView(
            children: [
              CustomText(
                text: "${TextConstant.welcomeText} ${TextConstant.handEmoji}",
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: blackColor,
              ),
              const SizedBox(height: 8),
              CustomText(
                text: TextConstant.loginMessage,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: greyColor,
              ),
              const SizedBox(height: 25),
              RichText(
                text: TextSpan(
                  text: TextConstant.email,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                  children: [
                    TextSpan(
                      text: TextConstant.star,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: redColor,
                      ),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                  controller: _emailController, hintText: 'Enter Email'),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: TextConstant.password,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                  children: [
                    TextSpan(
                      text: TextConstant.star,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: redColor,
                      ),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Enter Password',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPassword()));
                  },
                  child: CustomText(
                    text: TextConstant.forgetPassword,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: mainColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    final loginData = state.loginData;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Welcome, ${loginData.result?.name}!"),
                          duration: const Duration(seconds: 3)),
                    );
                    Future.delayed(const Duration(milliseconds: 500), () {
                      // Small delay
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavigation()),
                      );
                    });
                  } else if (state is LoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(state.message),
                          duration: const Duration(seconds: 3)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return InkWell(
                    onTap: () {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Please enter both email and password."),
                              duration: Duration(seconds: 3)),
                        );
                        return; 
                      }

                      context.read<LoginBloc>().add(LoginButtonPressed(
                            email: email,
                            password: password,
                          ));
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: CustomText(
                          text: TextConstant.login,
                          fontSize: 16,
                          color: whiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
