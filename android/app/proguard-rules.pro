# Just Audio & Audio Service Proguard Rules
-keep class com.ryanheise.audioservice.** { *; }
-keep class com.ryanheise.just_audio.** { *; }
-keep class com.google.android.exoplayer2.** { *; }
-keep class androidx.media3.** { *; }
-keep class com.google.android.gms.ads.** { *; }
-dontwarn com.google.android.exoplayer2.**
-dontwarn androidx.media3.**
