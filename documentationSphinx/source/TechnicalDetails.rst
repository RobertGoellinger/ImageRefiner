Technical details
=================


ImageHandler.AbstractImageHandler
---------------------------------

The AbstractImageHandler is an abstract class used to derive the DirectoryCrawler and the ImageAnalyzer. 
The AbstractImageHandler requires the following properties and methods to be implemented by all derived classes.

.. code-block:: matlab

  properties (Abstract)
    ImageDtoCollection
  end
  
  methods (Abstract)
    execute(obj);
  end


The execution of all instance derived from this abstract class may be called via the execute function: 

.. code-block:: matlab

  abstractImageHandlerInstance = ImageHandler.AbstractImageHandler();
  abstractImageHandlerInstance.execute();


ImageHandler.DirectoryCrawler
-----------------------------

The DirectoryCrawler is used to find all images inside a given folder that match the string requirement defined inside the m-file :file:`Settings.m`.

To create an instance please run the constructor: 

.. code-block:: matlab

  directoryCrawlerInstance = ImageHandler.DirectoryCrawler()
  directoryCrawlerInstance.execute()


ImageHandler.ImageAnalyzer
--------------------------

The ImageAnalyzer contains the whole business logic used for analysing the nephrological images. 



Export.AbstractExporter
-----------------------

The AbstractExporter-Class is a prototype for all Export-Classes to derive from. 
All Exporter classes inside the project need to implement the following properties: 

.. code-block:: matlab

  properties (Abstract)
    ExportDirectory
    ImageDtoCollection
    Summary
    Settings
  end
    


