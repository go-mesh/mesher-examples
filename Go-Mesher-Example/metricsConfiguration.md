
## Configuring Grafana Dashboard 
Mesher exposes metric information in Prometheus format. We can configure a grafana Dashboard to monitor our running services.


#### **Configuration** 
 In mesher.yaml file add these configuration
 ```
 admin:
   serverUri: 0.0.0.0:30102 
   goRuntimeMetrics: true  # select true if you want run time information in metrics.
 ```

#### **steps**
  - Download Prometheus .
    * For downloading standalone binary distribution for windows/linux [click here](https://prometheus.io/download/)
    * Visit [Prometheus Installation guide](https://prometheus.io/docs/prometheus/latest/installation/) for more info. 
  - Download grafana 
    * For  Downloading standalone binaries distribution for windows/linux/mac  [click here](https://grafana.com/grafana/download) .
    * Visit [Grafana Installation guide](http://docs.grafana.org/installation/) for more info.
 - Configure Prometheus to monitor your service.
    > Prometheus collects metrics from monitored targets by scraping metrics HTTP endpoints on these targets.
Prometheus is configured via command-line flags and a configuration file.Save the basic Prometheus configuration as a file named prometheus.yml
For a complete specification of configuration options, see the [configuration documentation](https://prometheus.io/docs/prometheus/latest/configuration/configuration/).
- Run Prometheus binary and Grafana binary. By default Prometheus will run on 9090 port and Grafana will run on 3000 port.
- Go to http://localhost:3000 in your browser. Login to grafana (default username/password is admin/admin).
- Go to Data Sources and click add data source. Give any name for your data source. 
Select type as Prometheus. In URL field give address where prometheus is running (If you are running locally on deafult port then give it as http://localhost:9090).  Click on Add.
- In main menu bar click on Dasboards then click on import. 
- Give the json configuration file and click load. It will import a new dashboard.
- Change the Data source for all the template variable and pannels to the data source which you have added.
   * Go To all pannels in your dashboard .Click edit and select the data source which you have added.
   * Click on settings icon on the top of dashboard. Click Templating and edit all varibles. Select the Data source and click update.
   
* Your Dashboard is ready to monitor your services.
