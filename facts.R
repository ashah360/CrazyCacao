# Facts about cacao to be generated randomly for the homepage side panel 

# Sources: 
# https://www.finedininglovers.com/stories/cacao-facts/

facts <- c("It takes about 400 beans to make a pound of chocolate. At around 2 ounces each, that's roughly enough to make 8 candy bars!",
           "Cacao contains many properties that can help combat Heart disease. This is a result of the flavanoids from the plant itself.",
           "The estimated annual worldwide cocoa production is almost 3 million tons. That's enough to make roughly 50 billion full-sized chocolate bars.",
           "Indonesia is the world's third largest producer of cacao, but most of its growers have never even tasted chocolate due to the seeds being exported before fermentation.",
           "The ninth emperor of the Aztecs, Montezuma II, was called the King of Chocolate. As a wealthy ruler, legend has it that he had stores of nearly a billion cocoa beans.",
           "Small pieces of cocoa beans known as \"nibs\", are fermented, dried, and eaten raw or toasted. These are known as nature's chocolate chips!",
           "Cacao has a very strong antioxidant power that can help protect against cell aging, tumors, and diseases such as Alzheimer's.",
           "Cacao is the purest form of chocolate that can be consumed. Not only is it unprocessed in its raw form, but it is consideraby different than the powdered form of cocoa.",
           "Cacao is categorized into three main varities. Crillo, the first one, is very valuable, fragrant, and delicate. Forastero is the most common and also the most bitter. Trinitario is a hybrid of both Criollo and Forastero with a somewhat fruity aroma.",
           "Cacao grows at the equator. Nearly all cacao trees grow within 20 degrees of the equator, and 75% of those grow within eight degrees.",
           "Fermentation of cacao beans is the process that occurs before drying, and varies depending on the type of cacao desired. This is a very important process when it comes to achieving high-quality chocolate.",
           "Cocoa and Cacao are two different thigs. Cocoa refers to cacao once it has been heated. Generally, cocoa refers to the powdered form, which has usually been exposed to higher temperatures than cacao powder. In today's language, it is mostly synonymous with cacao.")

generateFact <- function() {
  return(sample(facts, 1))
}
