package com.HomeService.model;



import java.io.Serializable;



/**

 * ContactMessage model class.

 * Represents one message submitted from the Contact Us form.

 */

public class ContactMessage implements Serializable {



    private int messageId;

    private String fullName;

    private String email;

    private String phone;

    private String subject;

    private String message;

    private String status;



    /**

     * Default constructor required for JavaBeans.

     */

    public ContactMessage() {

    }



    /**

     * Constructor without messageId for inserting new records.

     *

     * @param fullName user's full name

     * @param email user's email

     * @param phone user's phone number

     * @param subject message subject

     * @param message message content

     * @param status message status

     */

    public ContactMessage(String fullName, String email, String phone, String subject, String message, String status) {

        this.fullName = fullName;

        this.email = email;

        this.phone = phone;

        this.subject = subject;

        this.message = message;

        this.status = status;

    }



    /**

     * Returns the message ID.

     *

     * @return messageId

     */

    public int getMessageId() {

        return messageId;

    }



    /**

     * Sets the message ID.

     *

     * @param messageId message ID

     */

    public void setMessageId(int messageId) {

        this.messageId = messageId;

    }



    /**

     * Returns the full name.

     *

     * @return fullName

     */

    public String getFullName() {

        return fullName;

    }



    /**

     * Sets the full name.

     *

     * @param fullName full name

     */

    public void setFullName(String fullName) {

        this.fullName = fullName;

    }



    /**

     * Returns the email.

     *

     * @return email

     */

    public String getEmail() {

        return email;

    }



    /**

     * Sets the email.

     *

     * @param email email address

     */

    public void setEmail(String email) {

        this.email = email;

    }



    /**

     * Returns the phone number.

     *

     * @return phone

     */

    public String getPhone() {

        return phone;

    }



    /**

     * Sets the phone number.

     *

     * @param phone phone number

     */

    public void setPhone(String phone) {

        this.phone = phone;

    }



    /**

     * Returns the subject.

     *

     * @return subject

     */

    public String getSubject() {

        return subject;

    }



    /**

     * Sets the subject.

     *

     * @param subject subject text

     */

    public void setSubject(String subject) {

        this.subject = subject;

    }



    /**

     * Returns the message text.

     *

     * @return message

     */

    public String getMessage() {

        return message;

    }



    /**

     * Sets the message text.

     *

     * @param message message content

     */

    public void setMessage(String message) {

        this.message = message;

    }



    /**

     * Returns the status.

     *

     * @return status

     */

    public String getStatus() {

        return status;

    }



    /**

     * Sets the status.

     *

     * @param status message status

     */

    public void setStatus(String status) {

        this.status = status;

    }

}