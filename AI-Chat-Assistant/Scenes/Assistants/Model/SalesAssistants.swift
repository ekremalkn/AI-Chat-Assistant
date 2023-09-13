//
//  SalesAssistants.swift
//  AI-Chat-Assistant
//
//  Created by Ekrem Alkan on 13.09.2023.
//

import Foundation

extension AssistantsProvider {
    static let salesAssistants: [Assistant] = [
        .init(assistantTitle: "Follow-up Messages", assistantPrompt: "You are a Sales Representative. Today, your task is to draft a follow-up message for a lead we previously contacted. Here is some initial information to help you with the request: Lead information: [Details about the lead] Previous communication details: [Details about our previous communication with the lead]"),
        
        .init(assistantTitle: "Initial Outreach", assistantPrompt: "You are a Sales Representative. Today, your task is to draft an initial outreach email to a potential lead. Here is some initial information to help you with the request: Lead information: [Details about the lead] Product/service details: [Details about the product/service we are offering]"),
        
        .init(assistantTitle: "SNAP Selling", assistantPrompt: "You are a Sales Representative. Today, your task is to craft a sales approach based on the SNAP selling technique for a sales conversation with a potential customer. Here is some initial information to help you with the request: Customer information: [Details about the potential customer] Product/service details: [Details about the product/service we are offering]"),
        
        .init(assistantTitle: "MEDDIC Sales Process", assistantPrompt: "You are a Sales Representative. Today, your task is to craft a sales approach based on the MEDDIC sales process for a sales conversation with a potential customer. Here is some initial information to help you with the request: Customer information: [Details about the potential customer] Product/service details: [Details about the product/service we are offering]"),
        
        .init(assistantTitle: "BANT Qualification", assistantPrompt: "You are a Sales Representative. Today, your task is to create BANT qualification questions for a sales conversation with a potential customer. Here is some initial information to help you with the request: Customer information: [Details about the potential customer] Product/service details: [Details about the product/service we are offering]"),
        
        .init(assistantTitle: "Solution Selling", assistantPrompt: "You are a Sales Representative. Today, your task is to craft a solution selling approach for a sales conversation with a potential customer. Here is some initial information to help you with the request: Customer needs: [Details about the potential customer’s needs] Product/service details: [Details about the product/service we are offering]You are a Sales Representative. Today, your task is to craft a solution selling approach for a sales conversation with a potential customer. Here is some initial information to help you with the request: Customer needs: [Details about the potential customer’s needs] Product/service details: [Details about the product/service we are offering]"),
        
        .init(assistantTitle: "Value Selling", assistantPrompt: "You are a Sales Representative. Today, your task is to create a value selling proposition for our new software product. Here is some initial information to help you with the request: Product/service features: [Details about the software product’s features] Customer needs: [Details about the potential customer’s needs]"),
        
        .init(assistantTitle: "Challenger Sale", assistantPrompt: "You are a Sales Representative. Today, your task is to craft a Challenger Sale approach for a sales conversation with a potential customer. Here is some initial information to help you with the request: Customer information: [Details about the potential customer] Product/service details: [Details about the product/service we are offering]"),
        
        .init(assistantTitle: "SPIN Selling", assistantPrompt: "You are a Sales Representative. Today, your task is to create SPIN selling questions for a sales conversation with a potential customer. Here is some initial information to help you with the request: Customer information: [Details about the potential customer] Product/service details: [Details about the product/service we are offering]"),
        
        .init(assistantTitle: "Feature-Advantage-Benefit Statements", assistantPrompt: "You are a Sales Representative. Today, your task is to create Feature-Advantage-Benefit (FAB) statements for our new software product. Here is some initial information to help you with the request: Product/service features: [Details about the software product’s features] Target audience: [Details about the target audience]"),
        
        .init(assistantTitle: "Leveraging CRM Tools To Manage and Track Sales Efforts", assistantPrompt: "Imagine you are an experienced sales manager with in-depth knowledge of CRM (Customer Relationship Management) tools and software, specifically [CRM Tool]. You have been asked to explain how to leverage CRM tools and software to better manage and track sales efforts for a [Product/Service]. Please provide a detailed guide on best practices and strategies for utilizing [CRM Tool] to enhance your sales process, including the following aspects: 1. CRM Tool Overview: Provide a brief introduction to [CRM Tool], highlighting its key features and capabilities in the context of managing and tracking sales efforts for [Product/Service] 2. Contact Management: Explain how to effectively use [CRM Tool] for managing and organizing contacts, leads, and customers related to [Product/Service] 3. Sales Pipeline Management: Describe the process of setting up and managing a sales pipeline within [CRM Tool] to monitor and optimize the sales cycle for [Product/Service] 4. Task and Activity Tracking: Discuss how to use [CRM Tool] to track sales tasks, activities, and interactions, enabling better follow-up and relationship building with prospects and clients 5. Sales Forecasting and Reporting: Explain how to leverage [CRM Tool]'s forecasting and reporting features to gain insights into sales performance and make data-driven decisions for [Product/Service] 6. Team Collaboration: Offer guidance on using [CRM Tool] for promoting collaboration and communication among sales team members, ensuring seamless coordination in the sales process for [Product/Service] 7. Integration and Automation: Suggest strategies for integrating [CRM Tool] with other business tools and automating routine tasks to improve efficiency and productivity in the sales process 8. Customization and Scalability: Discuss the importance of customizing [CRM Tool] to suit the unique needs of [Product/Service] and its scalability to support the growth of your business Please provide a comprehensive guide and actionable insights on leveraging CRM tools and software, such as [CRM Tool], to better manage and track sales efforts for [Product/Service]."),
        
        .init(assistantTitle: "Set Sales Goals for Your Team", assistantPrompt: "As an accomplished sales goal strategist, develop a comprehensive and well-structured set of sales goals for the requester's team that takes into account the company's sales performance, industry trends, team size, and team capabilities. Ensure that the proposed sales goals are ambitious yet achievable, motivating, and aligned with the company's overall objectives. * Company Sales Performance: [Specify recent sales performance, e.g., growth rate, revenue, etc.] * Industry Trends: [Specify any relevant industry trends or factors, e.g., market growth, competition, etc.] * Team Size: [Specify the size of the sales team] * Team Capabilities: [Specify the team's strengths, weaknesses, and areas of expertise] Task Requirements: 1. Understand the company's sales performance, industry trends, team size, and team capabilities in the context of sales goal setting. 2. Analyze the unique factors and circumstances within the context of sales goal generation and customization. 3. Ensure the sales goals are ambitious yet achievable, motivating, and aligned with the company's overall objectives. 4. Develop a comprehensive set of sales goals for the requester's team that: * Addresses the specified company sales performance, industry trends, team size, and team capabilities * Offers diverse, effective, and value-driven goal recommendations * Is based on reputable, credible, and authoritative sources or platforms Best Practices Checklist: * Conduct thorough research on sales goal-setting best practices, case studies, and industry trends relevant to the specified company sales performance, team size, and team capabilities * Evaluate potential sales goals based on relevance, quality, popularity, and potential to satisfy the specified factors and circumstances * Consider a mix of short-term and long-term goals to ensure a diverse and comprehensive set of sales goals * Seek feedback, input, or collaboration from sales experts, team members, or peers to ensure a well-rounded and insightful set of sales goals * Regularly monitor sales goal trends, advances, and updates to refine and optimize the sales goals for maximum effectiveness and success Deliverable: Provide a comprehensive and well-structured set of sales goals tailored to the specified company sales performance, industry trends, team size, and team capabilities. The sales goals should be ambitious yet achievable, motivating, and aligned with the company's overall objectives. Format the content in markdown."),
        
        .init(assistantTitle: "Property Description for Real Estate Sales Platforms", assistantPrompt: "Imagine you are a skilled real estate professional with expertise in crafting compelling property descriptions for [Property Type] properties to be used on real estate sales platforms like [Platform] and [Platform]. You are asked to provide a well-written and enticing property description for a [Property Type] property that highlights its unique features, location, and other selling points. Please create a captivating property description for the [Property Type] property. Details of the property include: 1. Property Overview: [Property size], [Property type], [Number of rooms], [Unique design features], [Bathrooms] 2. Location and Neighborhood: [Amenities], [Schools], and [Transportation options] 3. Interior Features: [Flooring], [Fixtures], [Appliances], [Upgrades], [Renovations] 4. Exterior Features: [Landscaping], [Outdoor spaces] [Additional structures], [Swimming pool] 5. Lifestyle Benefits: [Proximity to recreational activities], [Shopping], [Dining options] 6. Community and Local Attractions: [Local attractions], [Community features] Please create an engaging and detailed property description for the [Property Type] property, addressing the aspects outlined above, to be used on real estate sales platforms like [Platform] and [Platform]. Words: [Word count] Paragraphs: [Paragraph count] Main call to action: [Call to action]"),
        
        .init(assistantTitle: "Write an Email Announcement for a New Property Listing", assistantPrompt: "As a real estate agent with a diverse client base, I have a new property listing that I need to announce to my email subscribers. The property has unique features and is located in a desirable location. * Number of Email Subscribers: [Specify the number of subscribers in your email list] * Property Details: [Provide specific details about the property such as location, size, type (e.g., residential, commercial), price, etc.] * Target Audience: [Specify who your main target audience is for this property] * Property Overview: [Property Type], [Size (sq. ft.)], [Number of Bedrooms], [Number of Bathrooms] * Location and Neighborhood: [Property Location], (Nearby Amenities), (Schools), (Transportation Options) * Key Features: (Feature 1), (Feature 2), (Feature 3) * Property Photos and Virtual Tour: [Link to Photos], [Link to Virtual Tour] * Special Offer or Incentive (if applicable): (Exclusive Preview or Discounted Fees) * Call to Action: (Schedule a Viewing), (Request More Information), (Visit Online Listing) * Contact Information: [Phone Number], [Email Address], [Website] Task Requirements: 1. Understand the specifics of the property listing, including its details, unique features, and target audience. 2. Write a compelling email announcement that highlights the key features of the property and its potential value to the target audience. 3. The email should have a catchy subject line to maximize open rates. 4. The content should be engaging and informative, providing all necessary details about the property. 5. Include a clear call to action to encourage recipients to inquire more about the property. Best Practices Checklist: * The email should have a catchy subject line to maximize open rates. * The content should highlight the unique features of the property. * All necessary details about the property should be provided. * A clear call to action should be included. Deliverable: Provide an email announcement for the new property listing that has a catchy subject line, highlights the unique features of the property, provides all necessary details, and includes a clear call to action. Format the content in markdown."),
        
        .init(assistantTitle: "Provide a Valuation for My Home", assistantPrompt: "As a seasoned real estate consultant, provide a comprehensive valuation of your home, considering the following aspects: Home Details: [Location], [Square Footage], [Number of Bedrooms], [Number of Bathrooms], [Age], [Lot Size], [Special Features or Upgrades] Market Trends: [Local Real Estate Market Trends] Recent Comparable Sales: [List 3-5 Comparable Home Sales in the Area] Neighborhood Factors: [Schools, Amenities, Safety, etc.] Task Requirements: Understand the specific home details and the client's objectives.Research the local real estate market trends and recent comparable home sales.Analyze neighborhood factors, such as schools, amenities, and safety.Perform a comprehensive valuation of the home based on these factors. Deliverable: Provide a comprehensive valuation of the client's home, considering market trends, recent comparable sales, and neighborhood factors. The valuation should be based on the home's details, including location, square footage, age, lot size, and any special features or upgrades. The report should provide a detailed explanation of the factors influencing the home's value and any recommendations for maximizing the value, if applicable."),
        
        .init(assistantTitle: "Value My Car", assistantPrompt: "As an experienced automotive valuation consultant, provide a comprehensive valuation of your car, considering the following aspects: Car Details: [Make], [Model], [Year], [Mileage], [Trim Level], [Color], [Interior Material] Vehicle History: [Accidents, Repairs, and Maintenance Records] Current Market Value: [Average Selling Price for Similar Vehicles] Condition: [Exterior Condition, Interior Condition, Mechanical Condition] Additional Features or Upgrades: [List Any Additional Features or Upgrades] Task Requirements: Understand the specific car details and the client's objectives. Research the current market value of similar vehicles. Analyze the vehicle's history, including accidents, repairs, and maintenance. Assess the car's condition, including exterior, interior, and mechanical. Consider any additional features or upgrades that may affect the value. Deliverable: Provide a comprehensive valuation of the client's car, considering car details, vehicle history, current market value, condition, and any additional features or upgrades. The report should provide a detailed explanation of the factors influencing the car's value and any recommendations for maximizing the value, if applicable."),
        
        .init(assistantTitle: "Generate Some Tactics to Close a Sale for the Product", assistantPrompt: "Generate a list of [number] tactics to close a sale for [product/service]."),
        
        .init(assistantTitle: "Generate Some Ways to Upsell or Cross-sell the Product", assistantPrompt: "Generate a list of [number] ways to upsell or cross-sell [product/service]."),
        
        .init(assistantTitle: "Write a Script for a Sales Video about the Product", assistantPrompt: "Write a [number of words] script for a sales video about [product/service]."),
        
        .init(assistantTitle: "Generate Some Common Misconceptions about the Product", assistantPrompt: "Generate a list of [number] common misconceptions about [product/service] and the facts to dispel them."),
        
        .init(assistantTitle: "Write a Sales Deck for the Product", assistantPrompt: "Write a [number of words] sales deck for [product/service]."),
        
        .init(assistantTitle: "Generate Some Keywords for Search Engine Optimization", assistantPrompt: "Generate a list of [number] keywords related to [product/service] for search engine optimization."),
        
        .init(assistantTitle: "Write a Script for a Sales Webinar", assistantPrompt: "Write a [number of words] script for a sales webinar about [product/service]."),
        
        .init(assistantTitle: "Generate Some Different Pricing Options for the Product", assistantPrompt: "Generate a list of [number] different pricing options for [product/service]."),
        
        .init(assistantTitle: "Write a Brochure about the Product", assistantPrompt: "Write a [number of words] brochure about [product/service]."),
        
        .init(assistantTitle: "Write a Value Proposition for the Product", assistantPrompt: "Write a [number of words] value proposition for [product/service]."),
        
        .init(assistantTitle: "Write a Proposal for the Potential Client", assistantPrompt: "Write a [number of words] proposal for [potential client] to consider [product/service]."),
        
        .init(assistantTitle: "Write an Email Template to Follow up with Leads after Meeting", assistantPrompt: "Write a [number of words] email template to follow up with leads after [event/meeting related to product/service]."),
        
        .init(assistantTitle: "Write a White-paper on the Future of the Product", assistantPrompt: "Write a [number of words] white-paper on the future of [industry/field related to product/service]."),
        
        .init(assistantTitle: "Generate Some Statistics and Facts to Support the Effectiveness of Products", assistantPrompt: "Generate a list of [number] statistics and facts that support the effectiveness of [product/service]."),
        
        .init(assistantTitle: "Write a Testimonial from a Satisfied Customer", assistantPrompt: "Write a [number of words] testimonial from a satisfied customer of [product/service]."),
        
        .init(assistantTitle: "Provide Some Questions and Answers about the Product", assistantPrompt: "Provide a list of [number] frequently asked questions about [product/service] and their answers."),
        
        .init(assistantTitle: "Write a Case Study on a Successful Implementation", assistantPrompt: "Write a [number of words] case study on a successful implementation of [product/service]."),
        
        .init(assistantTitle: "Generate Some Different Use Cases for the Product", assistantPrompt: "Generate a list of [number] different use cases for [product/service]."),
        
        .init(assistantTitle: "Write a Product Description for the Product", assistantPrompt: "Write a [number of words] product description for [product/service]."),
        .init(assistantTitle: "Show Some Benefits of the Product", assistantPrompt: "Create a list of [number] benefits of [product/service]."),
        .init(assistantTitle: "Write an Email to Ask for a Testimonial", assistantPrompt: "Write a [number of words] email to [prospect’s name] to ask for a testimonial."),
        .init(assistantTitle: "Write an Email to Ask for a Second Meeting", assistantPrompt: "Write a [number of words] email to [prospect’s name] to ask for a second meeting."),
        
        .init(assistantTitle: "Create an Email to Send a Limited Time Offer", assistantPrompt: "Create an email to send [prospect’s name] a limited time offer for [product/service]."),
        
        .init(assistantTitle: "Provide Some Tips to Close a Sales Deal", assistantPrompt: "Provide [number] tips to close a sales deal with [prospect’s name]."),
        
        .init(assistantTitle: "Write an Email to Ask for a Decision on the Product", assistantPrompt: "Write a [number of words] email to ask for [prospect’s name] decision on [product/service]."),
        
        .init(assistantTitle: "Create an Email to Send a Free Trial", assistantPrompt: "Create an email to send [prospect’s name] a free trial of [product/service]."),
        
        .init(assistantTitle: "Write an Email to Send a Case Study", assistantPrompt: "Write a [number of words] email to send [prospect’s name] a case study of [product/service]."),
        
        .init(assistantTitle: "Provide Some Reasons to Show Our Strengths from Competitors", assistantPrompt: "Provide [number] reasons why [product/service] is better than the competitors."),
        
        .init(assistantTitle: "Provide Some Questions During a Sales Call", assistantPrompt: "Provide [number] questions to ask during a sales call with [prospect’s name]."),
        
        .init(assistantTitle: "Provide a List of Closing Techniques", assistantPrompt: "Provide a list of [number] closing techniques for [sales situation, e.g. phone call, in-person meeting, etc.]."),
        
        .init(assistantTitle: "Write a Closing Script for the Product", assistantPrompt: "Write a [number of words] closing script for [product/service]."),
        
        .init(assistantTitle: "Write an Objection Handling Script for the Product", assistantPrompt: "Write a [number of words] objection handling script for [product/service]."),
        
        .init(assistantTitle: "Write a Proposal for the Product", assistantPrompt: "Write a [number of words] proposal for [product/service]."),
        
        .init(assistantTitle: "Write a Follow-up Email", assistantPrompt: "Write a [number of words] follow-up email for [product/service]."),
        
        .init(assistantTitle: "Provide Reasons to Buy the Product", assistantPrompt: "Provide [number] reasons why [prospect’s company] should buy [product/service]."),
        
        .init(assistantTitle: "Create an Effective Sales Pitch", assistantPrompt: "Create an effective sales pitch for [product/service]."),
        
        .init(assistantTitle: "Recommend Cross-selling Opportunities for the Business", assistantPrompt: "What cross-selling opportunities would you recommend for [business]?"),
        
        .init(assistantTitle: "Generate Leads for the Company", assistantPrompt: "What are some creative ways to generate leads for my <niche> company?"),
        .init(assistantTitle: "Recommend Product Customization", assistantPrompt: "What product customization would you recommend for this customer? <include customer details below>"),
        .init(assistantTitle: "Sales Development Representative (SDR) to Send an Email to Potential Client", assistantPrompt: "I want you to act as a Sales Development Representative (SDR) and send an email to potential client who has recently shown interest in our industry."),
        
        .init(assistantTitle: "Sales Development Representative (SDR) to Follow up with an Unresponsive Lead", assistantPrompt: "I want you to act as a Sales Development Representative (SDR) and follow up with a lead who has not responded to our previous attempts to contact them."),
        
        .init(assistantTitle: "Sales Development Representative (SDR) to Follow up with a Potential Lead", assistantPrompt: "I want you to act as a Sales Development Representative (SDR) and follow up with a lead who has recently requested a POC of our product."),
        
        .init(assistantTitle: "Sales Development Representative (SDR) for a Potential Contract for the Product", assistantPrompt: "I want you to act as a Sales Development Representative (SDR) and reach out to a potential client who has recently requested a contract for our product."),
        
        .init(assistantTitle: "Sales Development Representative (SDR) to Follow up with a Potential Client", assistantPrompt: "I want you to act as a Sales Development Representative (SDR) and follow up with a lead who has shown interest in our product but hasn't scheduled a call yet."),
        
        .init(assistantTitle: "Sales Development Representative (SDR) to Find More Clues among Potential clients", assistantPrompt: "I want you to act as a Sales Development Representative (SDR) and reach out to a potential client who has recently been added to our CRM as a lead."),
        
        .init(assistantTitle: "Sales Development Representative (SDR) to Learn More Information", assistantPrompt: "I want you to act as a Sales Development Representative (SDR) and schedule a call with a prospect who requested more information about our product."),
        
        .init(assistantTitle: "Sales Development Representative (SDR) to Call with Current Clients", assistantPrompt: "I want you to act as a Sales Development Representative (SDR) and schedule a call with a potential client who has recently requested a reference call with one of our current clients."),
        
        .init(assistantTitle: "Sales Development Representative (SDR) to Reach out to a Potential Client", assistantPrompt: "I want you to act as a Sales Development Representative (SDR) and reach out to a potential client who has been on our website for several minutes."),
        
        .init(assistantTitle: "Sales Development Representative (SDR) to Meet with the Executives", assistantPrompt: "I want you to act as a Sales Development Representative (SDR) and schedule a call with a potential client who has recently requested a meeting with one of our executives."),
    ]
}
