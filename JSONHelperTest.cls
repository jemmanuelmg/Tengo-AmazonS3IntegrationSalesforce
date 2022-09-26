@isTest
public class JSONHelperTest {

    @isTest
    static void testWriteStringField() {
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        Test.startTest();
        	String value = 'Test';
        	JSONHelper.writeStringField(gen, 'Key name', value);
        	value = null;
        	JSONHelper.writeStringField(gen, 'Key name', value);
        Test.stopTest();
        gen.writeEndObject();
        
    }
    
    @isTest
    static void testWriteBooleanField() {
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        Test.startTest();
        	Boolean value = true;
        	JSONHelper.writeBooleanField(gen, 'Key name', true);
        	value = null;
        	JSONHelper.writeBooleanField(gen, 'Key name', value);
        Test.stopTest();
        gen.writeEndObject();
       
    }
    
    @isTest
    static void testWriteNumberField() {
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        Test.startTest();
        	Integer value1 = 1;
        	JSONHelper.writeNumberField(gen, 'Key name', value1);
        	Double value2 = 3.1416;
        	JSONHelper.writeNumberField(gen, 'Key name', value2);
        	Decimal value3 = 3.1;
        	JSONHelper.writeNumberField(gen, 'Key name', value3);
        	value1 = null;
        	JSONHelper.writeNumberField(gen, 'Key name', value1);
        	value2 = null;
        	JSONHelper.writeNumberField(gen, 'Key name', value2);
        	value3 = null;
        	JSONHelper.writeNumberField(gen, 'Key name', value3);
        Test.stopTest();
        gen.writeEndObject();
       
    }
    
    @isTest
    static void testWriteDateField() {
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        Test.startTest();
        	Date value = Date.today();
        	JSONHelper.writeDateField(gen, 'Key name', value);
        	value = null;
        	JSONHelper.writeDateField(gen, 'Key name', value);
        Test.stopTest();
        gen.writeEndObject();
       
    }
    
    
}