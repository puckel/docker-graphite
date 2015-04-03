define(['settings'],
function (Settings) {
    return new Settings({
        datasources: {
            graphite: {
                type: 'graphite',
                url: 'http://'+window.location.host+window.location.pathname,
                default: true,
            },
            elasticsearch: {
                type: 'elasticsearch',
                url: 'http://'+window.location.host+window.location.pathname+'/es',
                index: 'grafana-dash',
                grafanaDB: true,
            },
            influx: {
                type: 'influxdb',
                url: "http://localhost:8086/db/collectd",
                username: "root",
                password: "root",
            },
        },
        // default start dashboard
        default_route: '/dashboard/file/default.json',
        // Elasticsearch index for storing dashboards
        grafana_index: "grafana-dash",
        // specify the limit for dashboard search results
        search: {
            max_results: 20
        },
        // set to false to disable unsaved changes warning
        unsaved_changes_warning: true,
        // set the default timespan for the playlist feature
        // Example: "1m", "1h"
        playlist_timespan: "1m",
        // Add your own custom pannels
        plugins: {
            panels: []
        }
    });
});
