##
# Preview
#
# Preview functionality for the CMS
#
class outpost.AutoBackup
    defaults:
        intervalInSeconds: 30

    constructor: (options={}) ->
        @options = _.defaults options, @defaults

        setInterval => @saveData(), @options.intervalInSections*10


    saveData: ->
        input = $(@options.input)
        
        # Update any hidden textareas that are using CKEditor
        # Then serialize the form.
        if CKEDITOR?
            for id,instance of CKEDITOR.instances
                instance.updateElement()

        data = input.serialize()

        $.ajax
            type: 'POST'
            dataType: "html"
            url: "#{_t.options.baseUrl}/backup"
            data:
                data
            
            beforeSend: (jqXHR, settings) ->
                # Spinner

            statusCode:
                200: (data, textStatus, jqXHR) ->
                    # Small feedback
                404: (jqXHR, textStatus, errorThrown) ->
                    # Let them know?
                500: (jqXHR, textStatus, errorThrown) ->
                    # Let them know?
