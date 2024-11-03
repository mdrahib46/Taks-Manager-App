class Urls{
  static const String _baseUrl = "http://35.73.30.144:2005/api/v1";

  static const String registration = "$_baseUrl/registration";
  static const String login = "$_baseUrl/login";
  static String emailVerification(String email) => "$_baseUrl/RecoverVerifyEmail/$email";
  static String verifyOTP(String email, String otp) => "$_baseUrl/RecoverVerifyOtp/$email/$otp";
  static String resetPassword = "$_baseUrl/RecoverResetPassword";
  static String createTask = "$_baseUrl/createTask";
  static String taskList = "$_baseUrl/listTaskByStatus/New";
  static String completedTaskList = "$_baseUrl/listTaskByStatus/Completed";
  static String inProgressTaskList = "$_baseUrl/listTaskByStatus/inProgress";
  static String canceledTaskList = "$_baseUrl/listTaskByStatus/Canceled";
  static String deleteTaskList(String taskId) => "$_baseUrl/deleteTask/$taskId";
  static String updateTaskStatus(String taskId, String taskStatus) => "$_baseUrl/updateTaskStatus/$taskId/$taskStatus";
  static String taskStatusCount = "$_baseUrl/taskStatusCount";
  static String updateProfile = "$_baseUrl/ProfileUpdate";

}