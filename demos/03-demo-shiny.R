#
# Demo 3: Shiny
# See: http://shiny.rstudio.com/
#      https://cran.r-project.org/web/packages/heatmaply/vignettes/heatmaply.html
#
library(shiny)
library(heatmaply)

# Load example dataset (BodyMap)
# In a more realistic application, we might add an option to let
# the user specify the dataset to load.
load('data/bodymap_eset.RData')

# Grab counts and rename columns of expression data to indicate tissue type
counts <- exprs(bodymap.eset)
colnames(counts) <- sprintf("%s_%d", as.character(phenoData(bodymap.eset)$tissue.type),
                           1:ncol(counts))

#
# Front-end
#
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel("Demo 3: Shiny RNA-Seq Sample Heatmaps"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput("similarity_metric", "Similarity Measure", 
                     c("Pearson"='pearson', "Spearman"='spearman', "Euclidean Distance"='dist'))
      ),
      
      # Below is where we specify the figure output to be displayed
      mainPanel(
          plotlyOutput("heatmap", height='920px')
      )
   )
))

#
# Back-end
#
server <- shinyServer(function(input, output) {
   # Here is where we render the actual heatmap
   output$heatmap <- renderPlotly({
       # Generate a similarity matrix using the specified metric
       if (input$similarity_metric == 'pearson') {
           mat <- cor(counts)
       } else if (input$similarity_metric == 'spearman') {
           mat <- cor(counts, method='spearman')
       } else {
           # get euclidean distance and convert to a similarity matrix
           mat <- as.matrix(dist(t(counts)))
           #mat <- 1 - (log1p(mat) / max(log1p(mat)))
       }

       # Display the matrix as a biclustering heatmap
       heatmaply(mat, k_col=3, k_row=3) %>% layout(margin=list(l=140, b=100))
   })
})

# Run our demo application
shinyApp(ui=ui, server=server)
