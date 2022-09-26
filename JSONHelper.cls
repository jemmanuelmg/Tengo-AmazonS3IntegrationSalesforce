public class JSONHelper  {
    
    public static void writeStringField(JSONGenerator gen, String fieldName, String fieldValue) {
        if (String.isEmpty(fieldValue) || fieldValue == null) {
            gen.writeNullField(fieldName); 
        } else {
            gen.writeStringField(fieldName, fieldValue);
        }
    }
    
    public static void writeBooleanField(JSONGenerator gen, String fieldName, Boolean fieldValue) {
        if (fieldValue == null) {
            gen.writeNullField(fieldName); 
        } else {
            gen.writeBooleanField(fieldName, fieldValue);
        }
    }
    
    public static void writeNumberField(JSONGenerator gen, String fieldName, Double fieldValue) {
        if (fieldValue == null) {
            gen.writeNullField(fieldName); 
        } else {
            gen.writeNumberField(fieldName, fieldValue);
        }
    }
    
    public static void writeNumberField(JSONGenerator gen, String fieldName, Integer fieldValue) {
        if (fieldValue == null) {
            gen.writeNullField(fieldName); 
        } else {
            gen.writeNumberField(fieldName, fieldValue);
        }
    }
    
    public static void writeNumberField(JSONGenerator gen, String fieldName, Decimal fieldValue) {
        if (fieldValue == null) {
            gen.writeNullField(fieldName); 
        } else {
            gen.writeNumberField(fieldName, fieldValue);
        }
    }
    
    public static void writeDateField(JSONGenerator gen, String fieldName, Date fieldValue) {
        if (fieldValue == null) {
            gen.writeNullField(fieldName); 
        } else {
            gen.writeDateField(fieldName, fieldValue);
        }
    }
}