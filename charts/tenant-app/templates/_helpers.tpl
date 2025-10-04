{{- define "mychart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mychart.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "mychart.tenantPassword" -}}
{{- $name := printf "%s-%s-db-user" .full .tenant -}}
{{- $existing := lookup "v1" "Secret" .ns $name -}}
{{- if $existing -}}
{{- index $existing.data "password" | b64dec -}}
{{- else -}}
{{- randAlphaNum .len -}}
{{- end -}}
{{- end -}}

{{- define "mychart.labels" -}}
app.kubernetes.io/name: {{ include "mychart.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
