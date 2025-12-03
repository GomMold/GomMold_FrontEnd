<h1>GomMold Frontend</h1>

<p>
  The mobile application for the GomMold system. Handles user interface, image upload for mold detection, chatbot interaction, history visualization, and authentication.
  Designed to connect directly to the GomMold Backend API and Firebase services.
</p>

<hr />

<h2>🚀 Technology Stack</h2>

<ul>
  <li><strong>Framework:</strong> Flutter (Dart)</li>
  <li><strong>State Management:</strong> Provider</li>
  <li><strong>Network:</strong> REST API (HTTP)</li>
  <li><strong>Authentication:</strong> Firebase Auth</li>
  <li><strong>Database:</strong> Firestore Database</li>
  <li><strong>Storage:</strong> Firebase Storage</li>
  <li><strong>Local Storage:</strong> Flutter Secure Storage, Shared Preferences</li>
  <li><strong>Image Processing:</strong> Image Picker</li>
  <li><strong>Platforms:</strong> Android, iOS, Web, macOS, Windows, Linux</li>
</ul>

<hr />

<h2>📁 Project Structure</h2>

<pre><code>GomMold_FrontEnd/
├── pubspec.yaml
├── analysis_options.yaml
├── firebase.json
├── README.md
│
├── assets/
│   └── images/
│       ├── chatbot_icon.png
│       └── logo.png
│
├── lib/
│   ├── main.dart
│   │
│   └── src/
│       ├── models/
│       │   └── detection.dart
│       │
│       ├── screens/
│       │   ├── initial_page.dart
│       │   ├── login_page.dart
│       │   ├── sign_up_page.dart
│       │   ├── homepage_time.dart
│       │   ├── image_page.dart
│       │   ├── identify_page.dart
│       │   ├── chatbot_page.dart
│       │   └── settings_page.dart
│       │
│       ├── services/
│       │   ├── api_service.dart
│       │   ├── auth_service.dart
│       │   └── firebase_service.dart
│       │
│       ├── utils/
│       │   ├── constants.dart
│       │   └── image_utils.dart
│       │
│       └── widgets/
│           ├── custom_button.dart
│           ├── custom_textfield.dart
│           └── card_item.dart
│
├── android/
├── ios/
├── web/
├── macos/
├── linux/
└── windows/
</code></pre>

<hr />

<h2>🔧 Installation</h2>

<h3>Clone the repository</h3>
<pre><code class="language-bash">git clone https://github.com/GomMold/GomMold_FrontEnd.git
cd GomMold_FrontEnd
</code></pre>

<h3>Install dependencies</h3>
<pre><code class="language-bash">flutter pub get
</code></pre>

<h3>Add Firebase configuration</h3>

<p>Place the following files:</p>

<table>
  <thead>
    <tr>
      <th>Platform</th>
      <th>File</th>
      <th>Location</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Android</td>
      <td><code>google-services.json</code></td>
      <td><code>android/app/</code></td>
    </tr>
    <tr>
      <td>iOS</td>
      <td><code>GoogleService-Info.plist</code></td>
      <td><code>ios/Runner/</code></td>
    </tr>
    <tr>
      <td>macOS</td>
      <td><code>GoogleService-Info.plist</code></td>
      <td><code>macos/Runner/</code></td>
    </tr>
  </tbody>
</table>

<h3>Run the app</h3>

<pre><code class="language-bash">flutter run
</code></pre>

<p>Run on specific device:</p>

<pre><code class="language-bash">flutter run -d android
flutter run -d ios
flutter run -d chrome
</code></pre>

<hr />

<h2>🔐 Environment Configuration</h2>

<p>Located in:</p>

<pre><code>lib/src/utils/constants.dart
</code></pre>

<p>Set your backend API URL:</p>

<pre><code class="language-dart">static const String baseUrl = "https://your-backend-url/api";
</code></pre>

<hr />

<h2>🧠 Core Features</h2>

<h3>Authentication</h3>
<ul>
  <li>Firebase Email/Password auth</li>
  <li>Token stored securely (<code>flutter_secure_storage</code>)</li>
</ul>

<h3>Mold Detection</h3>
<ul>
  <li>Select image from gallery</li>
  <li>Upload via <code>POST /api/mold/detect</code></li>
  <li>View result:
    <ul>
      <li>Status (warning/safe)</li>
      <li>Message</li>
      <li>Predictions</li>
      <li>Timestamp</li>
      <li>Image preview</li>
    </ul>
  </li>
</ul>

<h3>History</h3>
<ul>
  <li>Fetched from <code>/api/history/</code></li>
  <li>Displays previous mold detection results</li>
  <li>Navigate to full detail page (<code>IdentifyPage</code>)</li>
</ul>

<h3>Chatbot</h3>
<ul>
  <li>Initial greeting: <code>GET /api/chatbot/start</code></li>
  <li>User query: <code>POST /api/chatbot/query</code></li>
  <li>Interface built in <code>chatbot_page.dart</code></li>
</ul>

<h3>Settings</h3>
<ul>
  <li>Profile display</li>
  <li>Logout</li>
  <li>Preferences</li>
</ul>

<hr />

<h2>🔥 Frontend → Backend API Endpoints</h2>

<h3>Auth</h3>
<ul>
  <li><code>POST /api/auth/signup</code></li>
  <li><code>POST /api/auth/login</code></li>
</ul>

<h3>User</h3>
<ul>
  <li><code>GET /api/user/profile</code></li>
  <li><code>PATCH /api/user/update</code></li>
</ul>

<h3>Mold Detection</h3>
<ul>
  <li><code>POST /api/mold/detect</code></li>
</ul>

<h3>History</h3>
<ul>
  <li><code>GET /api/history/</code></li>
  <li><code>PUT /api/history/&lt;id&gt;</code></li>
</ul>

<h3>Chatbot</h3>
<ul>
  <li><code>GET /api/chatbot/start</code></li>
  <li><code>POST /api/chatbot/query</code></li>
</ul>

<hr />

<h2>📱 Build for Deployment</h2>

<h3>Build Release APK (Android)</h3>

<pre><code class="language-bash">flutter build apk --release
</code></pre>

<p>Output:</p>

<pre><code>build/app/outputs/flutter-apk/app-release.apk
</code></pre>

<h3>💻 <strong>Desktop Deployment (Windows/macOS)</strong></h3>

<h4>Run desktop app:</h4>
<pre><code>flutter run -d windows
flutter run -d macos
</code></pre>

<h4>Build desktop release:</h4>
<pre><code>flutter build windows
flutter build macos
</code></pre>

<hr>

<h3>🌐 <strong>Web Deployment</strong></h3>

<h4>Run in Chrome:</h4>
<pre><code>flutter run -d chrome
</code></pre>

<h4>Build Web Release:</h4>
<pre><code>flutter build web
</code></pre>

<p>Output in:</p>
<pre><code>build/web/
</code></pre>

<hr>

<p><em>No Procfile required for Flutter apps.</em></p>
