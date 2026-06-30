-keep class com.entouch.app.** { *; }
-keep class * extends com.google.firebase.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class com.example.en_touch.** { *; }

# Hive
-keep class * extends hive.HiveObject { *; }
-keepclassmembers class * {
    @hive.HiveField <fields>;
}

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }

# Don't warn about missing classes from optional deps
-dontwarn com.google.firebase.**