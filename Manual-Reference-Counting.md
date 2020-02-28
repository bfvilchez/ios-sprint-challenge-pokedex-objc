# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?)

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);
	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled

2. Which of these objects is autoreleased?  Why?

	1. `NSDate *yesterday = [NSDate date];`
        autoreleased because date is a method thats called on the class and those have code that has them be released after being used..
    
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];`
        its retained so we have to manually release it 
        
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];`
	property is  being initialized therfore it has to be to be manually released.
    
	4. `NSDate *food = [NSDate new];`
        similar to init, therefore we own the object and must release it, or specify autorelase afterwards
	NSDate *food =[ [NSDate new] autoRelease];`
    
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`
	needs to be autoreleased or manually released  because the object is being initialized
    
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`
    its already being autoReleased.. the method is being called right after its initialization..
        
3. Explain when you need to use the `NSAutoreleasePool`.
when your looping through an array since its possible for the array to multiple values which can take up alot of memory.

4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;


- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [[name new] autorelease];
    }
    return self;

@end
```
