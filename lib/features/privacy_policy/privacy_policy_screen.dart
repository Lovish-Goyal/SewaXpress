import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  bool isHindi = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildLanguageButton(String text, bool isSelected, bool isTablet) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isHindi = text == 'हिं';
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 16 : 12,
          vertical: isTablet ? 8 : 6,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.blue[600] : Colors.white,
            fontSize: isTablet ? 14 : 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required bool isTablet,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTablet ? 20 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: isTablet ? 12 : 8),
        Text(
          content,
          style: TextStyle(
            fontSize: isTablet ? 14 : 13,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
        SizedBox(height: isTablet ? 24 : 20),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isHindi ? 'लिंक खोलने में त्रुटि' : 'Error opening link',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    final isDesktop = screenWidth > 1200;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFF1976D2), Colors.grey[50]!],
            stops: const [0.0, 0.25],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(isTablet ? 30 : 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: isTablet ? 32 : 28,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        isHindi ? 'गोपनीयता नीति' : 'Privacy Policy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isTablet ? 32 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Language Toggle
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildLanguageButton('EN', !isHindi, isTablet),
                          _buildLanguageButton('हिं', isHindi, isTablet),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Expanded(
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 900 : double.infinity,
                  ),
                  margin: isDesktop
                      ? const EdgeInsets.symmetric(horizontal: 24)
                      : EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isTablet ? 40 : 30),
                      topRight: Radius.circular(isTablet ? 40 : 30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: EdgeInsets.all(isTablet ? 30 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Last Updated
                        Container(
                          padding: EdgeInsets.all(isTablet ? 16 : 12),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shield_outlined,
                                color: Colors.blue[600],
                                size: isTablet ? 20 : 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                isHindi
                                    ? 'अंतिम अपडेट: 16 जुलाई, 2025'
                                    : 'Last Updated: July 16, 2025',
                                style: TextStyle(
                                  fontSize: isTablet ? 14 : 12,
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: isTablet ? 30 : 24),

                        // Introduction
                        _buildSection(
                          title: isHindi ? '1. परिचय' : '1. Introduction',
                          content: isHindi
                              ? 'SewaxPress ("हम", "हमारा", या "कंपनी") आपकी गोपनीयता का सम्मान करता है। यह गोपनीयता नीति बताती है कि हम आपकी व्यक्तिगत जानकारी कैसे एकत्रित करते हैं, उपयोग करते हैं, और सुरक्षित रखते हैं जब आप हमारी SewaxPress मोबाइल एप्लिकेशन और सेवाओं का उपयोग करते हैं।'
                              : 'SewaxPress ("we", "our", or "Company") respects your privacy. This Privacy Policy explains how we collect, use, and protect your personal information when you use our SewaxPress mobile application and services.',
                          isTablet: isTablet,
                        ),

                        // Information We Collect
                        _buildSection(
                          title: isHindi
                              ? '2. हम कौन सी जानकारी एकत्रित करते हैं'
                              : '2. Information We Collect',
                          content: isHindi
                              ? 'हम निम्नलिखित प्रकार की जानकारी एकत्रित करते हैं:\n\n• व्यक्तिगत जानकारी: नाम, फोन नंबर, ईमेल पता\n• पता जानकारी: पिकअप और डिलीवरी पते\n• भुगतान जानकारी: कार्ड विवरण, UPI आईडी\n• ऑर्डर जानकारी: सेवा प्राथमिकताएं, निर्देश\n• डिवाइस जानकारी: IP पता, डिवाइस प्रकार\n• उपयोग डेटा: ऐप उपयोग पैटर्न\n• स्थान डेटा: सेवा प्रदान करने के लिए\n• संचार: चैट, कॉल रिकॉर्ड'
                              : 'We collect the following types of information:\n\n• Personal Information: Name, phone number, email address\n• Address Information: Pickup and delivery addresses\n• Payment Information: Card details, UPI ID\n• Order Information: Service preferences, instructions\n• Device Information: IP address, device type\n• Usage Data: App usage patterns\n• Location Data: For service delivery\n• Communications: Chat, call records',
                          isTablet: isTablet,
                        ),

                        // How We Use Information
                        _buildSection(
                          title: isHindi
                              ? '3. हम जानकारी का उपयोग कैसे करते हैं'
                              : '3. How We Use Information',
                          content: isHindi
                              ? 'हम आपकी जानकारी का उपयोग निम्नलिखित उद्देश्यों के लिए करते हैं:\n\n• सेवा प्रदान करना और ऑर्डर प्रोसेसिंग\n• पिकअप और डिलीवरी व्यवस्था\n• भुगतान प्रसंस्करण\n• ग्राहक सहायता प्रदान करना\n• सेवा में सुधार और नई सुविधाएं\n• सुरक्षा और धोखाधड़ी रोकथाम\n• कानूनी आवश्यकताओं का पालन\n• मार्केटिंग और प्रमोशन (केवल सहमति के साथ)\n• सेवा अपडेट और नोटिफिकेशन'
                              : 'We use your information for the following purposes:\n\n• Providing services and order processing\n• Arranging pickup and delivery\n• Payment processing\n• Customer support\n• Service improvement and new features\n• Security and fraud prevention\n• Legal compliance\n• Marketing and promotions (with consent only)\n• Service updates and notifications',
                          isTablet: isTablet,
                        ),

                        // Information Sharing
                        _buildSection(
                          title: isHindi
                              ? '4. जानकारी साझा करना'
                              : '4. Information Sharing',
                          content: isHindi
                              ? 'हम आपकी जानकारी निम्नलिखित परिस्थितियों में साझा कर सकते हैं:\n\n• सेवा प्रदाता: डिलीवरी पार्टनर, भुगतान गेटवे\n• कानूनी आवश्यकताएं: न्यायालय आदेश, कानूनी प्रक्रिया\n• सुरक्षा: धोखाधड़ी रोकथाम और सुरक्षा\n• व्यापार स्थानांतरण: विलय या अधिग्रहण की स्थिति में\n• सहमति: आपकी स्पष्ट सहमति के साथ\n\nहम आपकी व्यक्तिगत जानकारी को कभी भी बेचते या किराए पर नहीं देते हैं।'
                              : 'We may share your information in the following circumstances:\n\n• Service Providers: Delivery partners, payment gateways\n• Legal Requirements: Court orders, legal process\n• Security: Fraud prevention and security\n• Business Transfers: In case of merger or acquisition\n• Consent: With your explicit consent\n\nWe never sell or rent your personal information.',
                          isTablet: isTablet,
                        ),

                        // Data Security
                        _buildSection(
                          title: isHindi
                              ? '5. डेटा सुरक्षा'
                              : '5. Data Security',
                          content: isHindi
                              ? 'हम आपकी जानकारी की सुरक्षा के लिए निम्नलिखित उपाय करते हैं:\n\n• SSL/TLS एन्क्रिप्शन: सभी डेटा ट्रांसमिशन के लिए\n• डेटा एन्क्रिप्शन: संग्रहीत डेटा के लिए\n• पहुंच नियंत्रण: केवल अधिकृत कर्मचारियों को पहुंच\n• नियमित सुरक्षा ऑडिट: सिस्टम की जांच\n• फ़ायरवॉल सुरक्षा: नेटवर्क सुरक्षा\n• सुरक्षित सर्वर: प्रतिष्ठित डेटा सेंटर में\n• द्विगुणित प्रमाणीकरण: खाता सुरक्षा के लिए\n• नियमित बैकअप: डेटा हानि से बचाव'
                              : 'We implement the following security measures:\n\n• SSL/TLS Encryption: For all data transmission\n• Data Encryption: For stored data\n• Access Control: Only authorized personnel\n• Regular Security Audits: System monitoring\n• Firewall Protection: Network security\n• Secure Servers: In reputed data centers\n• Two-Factor Authentication: For account security\n• Regular Backups: Data loss prevention',
                          isTablet: isTablet,
                        ),

                        // Data Retention
                        _buildSection(
                          title: isHindi
                              ? '6. डेटा संग्रहण'
                              : '6. Data Retention',
                          content: isHindi
                              ? 'हम आपकी जानकारी को निम्नलिखित अवधि के लिए संग्रहीत करते हैं:\n\n• खाता जानकारी: खाता सक्रिय रहने तक\n• ऑर्डर इतिहास: 7 साल (कानूनी आवश्यकता)\n• भुगतान डेटा: 3 साल (वित्तीय नियम)\n• संचार रिकॉर्ड: 2 साल\n• उपयोग डेटा: 1 साल\n• स्थान डेटा: तत्काल हटाया जाता है\n\nखाता बंद करने पर, हम 30 दिनों के भीतर व्यक्तिगत डेटा हटा देते हैं (कानूनी आवश्यकताओं को छोड़कर)।'
                              : 'We retain your information for the following periods:\n\n• Account Information: Until account remains active\n• Order History: 7 years (legal requirement)\n• Payment Data: 3 years (financial regulations)\n• Communication Records: 2 years\n• Usage Data: 1 year\n• Location Data: Deleted immediately\n\nUpon account closure, we delete personal data within 30 days (except legal requirements).',
                          isTablet: isTablet,
                        ),

                        // Your Rights
                        _buildSection(
                          title: isHindi ? '7. आपके अधिकार' : '7. Your Rights',
                          content: isHindi
                              ? 'आपको निम्नलिखित अधिकार प्राप्त हैं:\n\n• पहुंच का अधिकार: अपना डेटा देखने का अधिकार\n• सुधार का अधिकार: गलत जानकारी सुधारने का अधिकार\n• हटाने का अधिकार: अपना डेटा हटाने का अधिकार\n• पोर्टेबिलिटी: अपना डेटा निकालने का अधिकार\n• आपत्ति का अधिकार: प्रोसेसिंग पर आपत्ति\n• सहमति वापसी: किसी भी समय सहमति वापस लेना\n• शिकायत: डेटा संरक्षण प्राधिकरण से शिकायत\n\nइन अधिकारों का उपयोग करने के लिए हमसे संपर्क करें।'
                              : 'You have the following rights:\n\n• Right to Access: View your data\n• Right to Rectification: Correct inaccurate information\n• Right to Erasure: Delete your data\n• Right to Portability: Export your data\n• Right to Object: Object to processing\n• Withdraw Consent: Revoke consent anytime\n• Lodge Complaint: With data protection authority\n\nContact us to exercise these rights.',
                          isTablet: isTablet,
                        ),

                        // Cookies and Tracking
                        _buildSection(
                          title: isHindi
                              ? '8. कुकीज़ और ट्रैकिंग'
                              : '8. Cookies and Tracking',
                          content: isHindi
                              ? 'हम निम्नलिखित ट्रैकिंग तकनीकों का उपयोग करते हैं:\n\n• आवश्यक कुकीज़: ऐप की कार्यक्षमता के लिए\n• विश्लेषण कुकीज़: उपयोग पैटर्न समझने के लिए\n• प्राथमिकता कुकीज़: आपकी सेटिंग्स याद रखने के लिए\n• विज्ञापन कुकीज़: प्रासंगिक विज्ञापन के लिए (केवल सहमति के साथ)\n• डिवाइस फिंगरप्रिंटिंग: सुरक्षा के लिए\n• एनालिटिक्स: Google Analytics, Firebase\n\nआप अपनी डिवाइस सेटिंग्स में कुकीज़ को नियंत्रित कर सकते हैं।'
                              : 'We use the following tracking technologies:\n\n• Essential Cookies: For app functionality\n• Analytics Cookies: To understand usage patterns\n• Preference Cookies: To remember your settings\n• Advertising Cookies: For relevant ads (with consent only)\n• Device Fingerprinting: For security purposes\n• Analytics: Google Analytics, Firebase\n\nYou can control cookies through your device settings.',
                          isTablet: isTablet,
                        ),

                        // Third-Party Services
                        _buildSection(
                          title: isHindi
                              ? '9. तीसरे पक्ष की सेवाएं'
                              : '9. Third-Party Services',
                          content: isHindi
                              ? 'हम निम्नलिखित तीसरे पक्ष की सेवाओं का उपयोग करते हैं:\n\n• भुगतान प्रसंस्करण: Razorpay, PayU, Paytm\n• मैप्स और नेविगेशन: Google Maps\n• SMS और नोटिफिकेशन: Firebase, AWS SES\n• एनालिटिक्स: Google Analytics, Mixpanel\n• क्लाउड स्टोरेज: AWS, Google Cloud\n• ग्राहक सहायता: Zendesk, Intercom\n• सोशल मीडिया: Facebook, Instagram APIs\n\nये सेवाएं अपनी गोपनीयता नीतियों के अधीन हैं।'
                              : 'We use the following third-party services:\n\n• Payment Processing: Razorpay, PayU, Paytm\n• Maps and Navigation: Google Maps\n• SMS and Notifications: Firebase, AWS SES\n• Analytics: Google Analytics, Mixpanel\n• Cloud Storage: AWS, Google Cloud\n• Customer Support: Zendesk, Intercom\n• Social Media: Facebook, Instagram APIs\n\nThese services are subject to their own privacy policies.',
                          isTablet: isTablet,
                        ),

                        // Children's Privacy
                        _buildSection(
                          title: isHindi
                              ? '10. बच्चों की गोपनीयता'
                              : '10. Children\'s Privacy',
                          content: isHindi
                              ? 'हमारी सेवा 18 वर्ष से कम उम्र के बच्चों के लिए नहीं है:\n\n• हम जानबूझकर 18 वर्ष से कम उम्र के बच्चों से जानकारी एकत्रित नहीं करते\n• यदि हमें पता चलता है कि किसी बच्चे की जानकारी एकत्रित हुई है, तो हम इसे तुरंत हटा देते हैं\n• माता-पिता अपने बच्चों की ऑनलाइन गतिविधियों की निगरानी करें\n• यदि आपको लगता है कि हमारे पास बच्चे की जानकारी है, तो तुरंत संपर्क करें\n\nहम बच्चों की सुरक्षा को गंभीरता से लेते हैं।'
                              : 'Our service is not intended for children under 18:\n\n• We do not knowingly collect information from children under 18\n• If we learn that we have collected a child\'s information, we delete it immediately\n• Parents should monitor their children\'s online activities\n• If you believe we have a child\'s information, contact us immediately\n\nWe take children\'s safety seriously.',
                          isTablet: isTablet,
                        ),

                        // International Data Transfers
                        _buildSection(
                          title: isHindi
                              ? '11. अंतर्राष्ट्रीय डेटा स्थानांतरण'
                              : '11. International Data Transfers',
                          content: isHindi
                              ? 'डेटा स्थानांतरण के बारे में जानकारी:\n\n• आपका डेटा मुख्यतः भारत में संग्रहीत होता है\n• कुछ सेवा प्रदाता अंतर्राष्ट्रीय हो सकते हैं\n• हम उपयुक्त सुरक्षा उपाय सुनिश्चित करते हैं\n• यूरोपीय संघ के मानकों का पालन\n• डेटा सुरक्षा समझौते सभी पार्टनर्स के साथ\n• आपकी स्पष्ट सहमति के बिना कोई स्थानांतरण नहीं\n\nहम आपके डेटा की सुरक्षा सुनिश्चित करते हैं।'
                              : 'Information about data transfers:\n\n• Your data is primarily stored in India\n• Some service providers may be international\n• We ensure appropriate security measures\n• Compliance with EU standards\n• Data security agreements with all partners\n• No transfers without your explicit consent\n\nWe ensure your data protection.',
                          isTablet: isTablet,
                        ),

                        // Data Breach Response
                        _buildSection(
                          title: isHindi
                              ? '12. डेटा उल्लंघन प्रतिक्रिया'
                              : '12. Data Breach Response',
                          content: isHindi
                              ? 'डेटा उल्लंघन की स्थिति में हमारी प्रतिक्रिया:\n\n• तत्काल सुरक्षा उपाय लागू करना\n• 72 घंटे के भीतर अधिकारियों को सूचित करना\n• प्रभावित उपयोगकर्ताओं को तुरंत सूचित करना\n• उल्लंघन के कारणों की जांच करना\n• भविष्य की रोकथाम के लिए उपाय करना\n• नियमित सुरक्षा ऑडिट बढ़ाना\n• पारदर्शी रिपोर्टिंग\n\nहम आपकी जानकारी की सुरक्षा को प्राथमिकता देते हैं।'
                              : 'Our response to data breaches:\n\n• Immediate security measures\n• Notify authorities within 72 hours\n• Immediate notification to affected users\n• Investigation of breach causes\n• Prevention measures for future\n• Enhanced security audits\n• Transparent reporting\n\nWe prioritize your information security.',
                          isTablet: isTablet,
                        ),

                        // Contact Information
                        _buildSection(
                          title: isHindi
                              ? '13. संपर्क जानकारी'
                              : '13. Contact Information',
                          content: isHindi
                              ? 'गोपनीयता संबंधी प्रश्नों के लिए संपर्क करें:\n\n📧 डेटा संरक्षण अधिकारी: privacy@sewaxpress.com\n📞 फोन: +91-9876543210\n📍 पता: SewaxPress Pvt. Ltd.\n    1234 Civil Lines, Ludhiana\n    Punjab 141001, India\n\n🕒 गोपनीयता सहायता समय:\n    सोमवार-शुक्रवार: 10:00 AM - 6:00 PM\n\n💬 लाइव चैट: ऐप में उपलब्ध\n🌐 वेबसाइट: www.sewaxpress.com/privacy'
                              : 'Contact us for privacy-related queries:\n\n📧 Data Protection Officer: privacy@sewaxpress.com\n📞 Phone: +91-9876543210\n📍 Address: SewaxPress Pvt. Ltd.\n    1234 Civil Lines, Ludhiana\n    Punjab 141001, India\n\n🕒 Privacy Support Hours:\n    Monday-Friday: 10:00 AM - 6:00 PM\n\n💬 Live Chat: Available in app\n🌐 Website: www.sewaxpress.com/privacy',
                          isTablet: isTablet,
                        ),

                        // Changes to Privacy Policy
                        _buildSection(
                          title: isHindi
                              ? '14. गोपनीयता नीति में परिवर्तन'
                              : '14. Changes to Privacy Policy',
                          content: isHindi
                              ? 'हम इस गोपनीयता नीति को समय-समय पर अपडेट कर सकते हैं। महत्वपूर्ण परिवर्तनों के बारे में हम आपको सूचित करेंगे:\n\n• ऐप नोटिफिकेशन के माध्यम से\n• ईमेल द्वारा (महत्वपूर्ण परिवर्तन)\n• वेबसाइट पर अपडेट\n• इन-ऐप बैनर\n\nनिरंतर उपयोग का मतलब है कि आप अपडेटेड नीति से सहमत हैं। कृपया नियमित रूप से इस नीति की समीक्षा करें।'
                              : 'We may update this Privacy Policy from time to time. We will notify you of significant changes through:\n\n• App notifications\n• Email (for significant changes)\n• Website updates\n• In-app banners\n\nContinued use means you agree to the updated policy. Please review this policy regularly.',
                          isTablet: isTablet,
                        ),

                        SizedBox(height: isTablet ? 40 : 30),

                        // Consent Section
                        Container(
                          padding: EdgeInsets.all(isTablet ? 20 : 16),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.green[200]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green[700],
                                    size: isTablet ? 24 : 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    isHindi ? 'आपकी सहमति' : 'Your Consent',
                                    style: TextStyle(
                                      fontSize: isTablet ? 16 : 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: isTablet ? 12 : 10),
                              Text(
                                isHindi
                                    ? 'हमारी सेवा का उपयोग करके, आप इस गोपनीयता नीति में वर्णित डेटा संग्रहण और उपयोग से सहमत होते हैं।'
                                    : 'By using our service, you consent to the data collection and usage as described in this Privacy Policy.',
                                style: TextStyle(
                                  fontSize: isTablet ? 14 : 13,
                                  color: Colors.grey[800],
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: isTablet ? 50 : 40),

                        // Optional link (e.g. to full policy or contact)
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontSize: isTablet ? 14 : 13,
                              ),
                              children: [
                                TextSpan(
                                  text: isHindi
                                      ? 'अधिक जानकारी के लिए हमारी वेबसाइट पर जाएं: '
                                      : 'For more information, visit our website: ',
                                ),
                                TextSpan(
                                  text: 'www.sewaxpress.com',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _launchURL('https://www.sewaxpress.com');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: isTablet ? 50 : 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
