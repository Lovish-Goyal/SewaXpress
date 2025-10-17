import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  bool isHindi = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                        isHindi ? 'नियम और शर्तें' : 'Terms & Conditions',
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
                                Icons.info_outline,
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
                              ? 'SewaxPress ("हम", "हमारा", या "कंपनी") में आपका स्वागत है। ये नियम और शर्तें ("शर्तें") आपके SewaxPress मोबाइल एप्लिकेशन और सेवाओं के उपयोग को नियंत्रित करती हैं। हमारी सेवाओं का उपयोग करके, आप इन शर्तों से सहमत होते हैं।'
                              : 'Welcome to SewaxPress ("we", "our", or "Company"). These Terms and Conditions ("Terms") govern your use of the SewaxPress mobile application and services. By using our services, you agree to these Terms.',
                          isTablet: isTablet,
                        ),

                        // Services
                        _buildSection(
                          title: isHindi ? '2. सेवाएं' : '2. Services',
                          content: isHindi
                              ? 'SewaxPress एक ऑन-डिमांड लॉन्ड्री सेवा प्रदाता है जो निम्नलिखित सेवाएं प्रदान करता है:\n\n• कपड़े धोना और सुखाना\n• ड्राई क्लीनिंग\n• इस्त्री सेवाएं\n• होम पिक-अप और डिलीवरी\n• विशेष कपड़ों की देखभाल\n\nहम अपनी सेवाओं को किसी भी समय संशोधित, निलंबित या बंद करने का अधिकार सुरक्षित रखते हैं।'
                              : 'SewaxPress is an on-demand laundry service provider offering the following services:\n\n• Washing and drying\n• Dry cleaning\n• Ironing services\n• Home pickup and delivery\n• Special garment care\n\nWe reserve the right to modify, suspend, or discontinue our services at any time.',
                          isTablet: isTablet,
                        ),

                        // User Responsibilities
                        _buildSection(
                          title: isHindi
                              ? '3. उपयोगकर्ता की जिम्मेदारियां'
                              : '3. User Responsibilities',
                          content: isHindi
                              ? 'आपकी जिम्मेदारियां:\n\n• सटीक और वर्तमान जानकारी प्रदान करना\n• खाता सुरक्षा बनाए रखना\n• समय पर भुगतान करना\n• कपड़ों की उचित तैयारी (जेब खाली करना)\n• सेवा नियमों का पालन करना\n• कर्मचारियों के साथ सम्मानजनक व्यवहार करना\n\nआप अपने खाते की सभी गतिविधियों के लिए जिम्मेदार हैं।'
                              : 'Your responsibilities include:\n\n• Providing accurate and current information\n• Maintaining account security\n• Making timely payments\n• Proper preparation of garments (empty pockets)\n• Following service guidelines\n• Treating staff respectfully\n\nYou are responsible for all activities under your account.',
                          isTablet: isTablet,
                        ),

                        // Pricing and Payment
                        _buildSection(
                          title: isHindi
                              ? '4. मूल्य निर्धारण और भुगतान'
                              : '4. Pricing and Payment',
                          content: isHindi
                              ? 'मूल्य निर्धारण:\n\n• सभी कीमतें भारतीय रुपये में हैं\n• कीमतें बिना पूर्व सूचना के बदली जा सकती हैं\n• लागू टैक्स अतिरिक्त होंगे\n• न्यूनतम ऑर्डर राशि लागू हो सकती है\n\nभुगतान:\n• भुगतान ऑनलाइन या डिलीवरी पर किया जा सकता है\n• स्वीकृत भुगतान विधियां: UPI, कार्ड, नकद\n• असफल भुगतान के लिए अतिरिक्त शुल्क लग सकते हैं'
                              : 'Pricing:\n\n• All prices are in Indian Rupees\n• Prices may change without prior notice\n• Applicable taxes will be additional\n• Minimum order amount may apply\n\nPayment:\n• Payment can be made online or on delivery\n• Accepted payment methods: UPI, Cards, Cash\n• Additional charges may apply for failed payments',
                          isTablet: isTablet,
                        ),

                        // Pickup and Delivery
                        _buildSection(
                          title: isHindi
                              ? '5. पिकअप और डिलीवरी'
                              : '5. Pickup and Delivery',
                          content: isHindi
                              ? 'पिकअप नीति:\n\n• निर्धारित समय पर उपलब्ध रहें\n• कपड़े पहले से तैयार रखें\n• विशेष निर्देश स्पष्ट रूप से बताएं\n• पिकअप के लिए न्यूनतम 2 घंटे पहले बुकिंग करें\n\nडिलीवरी नीति:\n• डिलीवरी का समय 24-48 घंटे है\n• आपातकालीन सेवा अतिरिक्त शुल्क पर उपलब्ध है\n• डिलीवरी के समय कपड़े जांच लें\n• विलंबित डिलीवरी के लिए मुआवजा नीति लागू है'
                              : 'Pickup Policy:\n\n• Be available at scheduled time\n• Keep garments ready for pickup\n• Provide clear special instructions\n• Book at least 2 hours in advance\n\nDelivery Policy:\n• Delivery time is 24-48 hours\n• Emergency service available at extra cost\n• Check garments upon delivery\n• Compensation policy applies for delayed delivery',
                          isTablet: isTablet,
                        ),

                        // Liability and Insurance
                        _buildSection(
                          title: isHindi
                              ? '6. दायित्व और बीमा'
                              : '6. Liability and Insurance',
                          content: isHindi
                              ? 'हमारी जिम्मेदारी:\n\n• कपड़ों की उचित देखभाल करना\n• समय पर सेवा प्रदान करना\n• क्षति के लिए उचित मुआवजा\n\nसीमाएं:\n• अधिकतम दायित्व कपड़े की लागत का 10 गुना\n• मूल्यवान वस्तुओं के लिए अलग से घोषणा आवश्यक\n• प्राकृतिक आपदा के लिए कोई दायित्व नहीं\n• रंग उड़ना या सिकुड़ना सामान्य है\n\nबीमा कवरेज सभी ऑर्डर के लिए उपलब्ध है।'
                              : 'Our Responsibility:\n\n• Proper care of garments\n• Timely service delivery\n• Fair compensation for damages\n\nLimitations:\n• Maximum liability is 10x garment cost\n• Valuable items require separate declaration\n• No liability for natural disasters\n• Color bleeding or shrinkage is normal\n\nInsurance coverage is available for all orders.',
                          isTablet: isTablet,
                        ),

                        // Cancellation and Refunds
                        _buildSection(
                          title: isHindi
                              ? '7. रद्दीकरण और रिफंड'
                              : '7. Cancellation and Refunds',
                          content: isHindi
                              ? 'रद्दीकरण नीति:\n\n• पिकअप से 1 घंटे पहले तक रद्द कर सकते हैं\n• प्रोसेसिंग शुरू होने के बाद रद्दीकरण संभव नहीं\n• आपातकालीन रद्दीकरण के लिए संपर्क करें\n\nरिफंड नीति:\n• रिफंड 3-5 कार्य दिवसों में\n• रिफंड मूल भुगतान विधि में\n• प्रोसेसिंग शुल्क काटा जा सकता है\n• सेवा संबंधी समस्याओं के लिए पूर्ण रिफंड\n\nग्राहक सहायता से संपर्क करें: support@sewaxpress.com'
                              : 'Cancellation Policy:\n\n• Can cancel up to 1 hour before pickup\n• No cancellation after processing begins\n• Contact for emergency cancellations\n\nRefund Policy:\n• Refunds processed in 3-5 business days\n• Refund to original payment method\n• Processing fees may be deducted\n• Full refund for service issues\n\nContact customer support: support@sewaxpress.com',
                          isTablet: isTablet,
                        ),

                        // Privacy and Data
                        _buildSection(
                          title: isHindi
                              ? '8. गोपनीयता और डेटा'
                              : '8. Privacy and Data',
                          content: isHindi
                              ? 'हम आपकी गोपनीयता का सम्मान करते हैं:\n\n• व्यक्तिगत जानकारी सुरक्षित रूप से संग्रहीत\n• केवल सेवा के लिए आवश्यक डेटा एकत्र करते हैं\n• तीसरे पक्ष के साथ डेटा साझा नहीं करते\n• डेटा सुरक्षा के लिए एन्क्रिप्शन का उपयोग\n• खाता हटाने का अधिकार सुरक्षित\n\nविस्तृत जानकारी के लिए हमारी गोपनीयता नीति देखें।'
                              : 'We respect your privacy:\n\n• Personal information stored securely\n• Only collect necessary data for service\n• No data sharing with third parties\n• Encryption used for data security\n• Right to delete account reserved\n\nSee our Privacy Policy for detailed information.',
                          isTablet: isTablet,
                        ),

                        // Prohibited Activities
                        _buildSection(
                          title: isHindi
                              ? '9. प्रतिबंधित गतिविधियां'
                              : '9. Prohibited Activities',
                          content: isHindi
                              ? 'निम्नलिखित गतिविधियां प्रतिबंधित हैं:\n\n• झूठी जानकारी प्रदान करना\n• अन्य उपयोगकर्ताओं का खाता उपयोग करना\n• सेवा में बाधा डालना\n• कर्मचारियों के साथ दुर्व्यवहार\n• भुगतान में धोखाधड़ी\n• कॉपीराइट उल्लंघन\n• गैरकानूनी गतिविधियां\n\nइन नियमों का उल्लंघन करने पर खाता बंद हो सकता है।'
                              : 'The following activities are prohibited:\n\n• Providing false information\n• Using another user\'s account\n• Interfering with service\n• Mistreating staff\n• Payment fraud\n• Copyright violations\n• Illegal activities\n\nViolation of these rules may result in account suspension.',
                          isTablet: isTablet,
                        ),

                        // Dispute Resolution
                        _buildSection(
                          title: isHindi
                              ? '10. विवाद समाधान'
                              : '10. Dispute Resolution',
                          content: isHindi
                              ? 'विवाद समाधान प्रक्रिया:\n\n• पहले ग्राहक सेवा से संपर्क करें\n• 48 घंटे के भीतर प्रतिक्रिया मिलेगी\n• आंतरिक समाधान प्रक्रिया का पालन करें\n• मध्यस्थता सेवा उपलब्ध है\n• कानूनी कार्रवाई अंतिम विकल्प\n\nसभी विवाद भारतीय कानून के अधीन हैं।\nक्षेत्राधिकार: पंजाब न्यायालय'
                              : 'Dispute Resolution Process:\n\n• Contact customer service first\n• Response within 48 hours\n• Follow internal resolution process\n• Mediation services available\n• Legal action as last resort\n\nAll disputes subject to Indian law.\nJurisdiction: Punjab Courts',
                          isTablet: isTablet,
                        ),

                        // Contact Information
                        _buildSection(
                          title: isHindi
                              ? '11. संपर्क जानकारी'
                              : '11. Contact Information',
                          content: isHindi
                              ? 'हमसे संपर्क करें:\n\n📧 ईमेल: support@sewaxpress.com\n📞 फोन: +91-9876543210\n📍 पता: SewaxPress Pvt. Ltd.\n    1234 Civil Lines, Ludhiana\n    Punjab 141001, India\n\n🕒 ग्राहक सेवा समय:\n    सोमवार-शनिवार: 9:00 AM - 8:00 PM\n    रविवार: 10:00 AM - 6:00 PM\n\n💬 लाइव चैट: ऐप में उपलब्ध'
                              : 'Contact Us:\n\n📧 Email: support@sewaxpress.com\n📞 Phone: +91-9876543210\n📍 Address: SewaxPress Pvt. Ltd.\n    1234 Civil Lines, Ludhiana\n    Punjab 141001, India\n\n🕒 Customer Service Hours:\n    Monday-Saturday: 9:00 AM - 8:00 PM\n    Sunday: 10:00 AM - 6:00 PM\n\n💬 Live Chat: Available in app',
                          isTablet: isTablet,
                        ),

                        // Changes to Terms
                        _buildSection(
                          title: isHindi
                              ? '12. नियमों में परिवर्तन'
                              : '12. Changes to Terms',
                          content: isHindi
                              ? 'हम इन नियमों और शर्तों को किसी भी समय संशोधित कर सकते हैं। महत्वपूर्ण परिवर्तनों के बारे में हम आपको सूचित करेंगे:\n\n• ऐप नोटिफिकेशन के माध्यम से\n• ईमेल द्वारा\n• वेबसाइट पर अपडेट\n\nनिरंतर उपयोग का मतलब है कि आप नई शर्तों से सहमत हैं। नियमित रूप से इन शर्तों की समीक्षा करें।'
                              : 'We may modify these Terms and Conditions at any time. We will notify you of significant changes through:\n\n• App notifications\n• Email updates\n• Website updates\n\nContinued use means you agree to the new terms. Please review these terms regularly.',
                          isTablet: isTablet,
                        ),

                        SizedBox(height: isTablet ? 40 : 30),

                        // Acceptance Section
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
                                    Icons.check_circle,
                                    color: Colors.green[600],
                                    size: isTablet ? 24 : 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    isHindi ? 'स्वीकृति' : 'Acceptance',
                                    style: TextStyle(
                                      fontSize: isTablet ? 18 : 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                isHindi
                                    ? 'SewaxPress सेवाओं का उपयोग करके, आप इन नियमों और शर्तों से पूर्ण रूप से सहमत होते हैं। यदि आप इन शर्तों से सहमत नहीं हैं, तो कृपया हमारी सेवाओं का उपयोग न करें।'
                                    : 'By using SewaxPress services, you fully agree to these Terms and Conditions. If you do not agree to these terms, please do not use our services.',
                                style: TextStyle(
                                  fontSize: isTablet ? 14 : 12,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: isTablet ? 30 : 20),

                        // Footer
                        Center(
                          child: Column(
                            children: [
                              Text(
                                '© 2025 SewaxPress Pvt. Ltd.',
                                style: TextStyle(
                                  fontSize: isTablet ? 12 : 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                isHindi
                                    ? 'सभी अधिकार सुरक्षित'
                                    : 'All rights reserved',
                                style: TextStyle(
                                  fontSize: isTablet ? 12 : 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20),
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
            fontSize: isTablet ? 14 : 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? const Color(0xFF1976D2) : Colors.white,
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
    return Container(
      margin: EdgeInsets.only(bottom: isTablet ? 24 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTablet ? 20 : 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1976D2),
            ),
          ),
          SizedBox(height: isTablet ? 12 : 10),
          Text(
            content,
            style: TextStyle(
              fontSize: isTablet ? 16 : 14,
              height: 1.6,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
