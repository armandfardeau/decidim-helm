{{/*
Expand the name of the chart.
*/}}
{{- define "decidim-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "decidim-helm.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified web app name.
We truncate at 59 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "decidim-helm.webFullname" -}}
{{- if .Values.webFullnameOverride }}
{{- .Values.web.fullname | trunc 59 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.web.name }}
{{- printf "%s-%s-%s" .Release.Name "web" $name | trunc 59 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified web app name.
We truncate at 59 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "decidim-helm.sdqFullname" -}}
{{- if .Values.sdqFullnameOverride }}
{{- .Values.web.fullname | trunc 59 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.web.name }}
{{- printf "%s-%s-%s" .Release.Name "sdq" $name | trunc 59 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "decidim-helm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "decidim-helm.labels" -}}
helm.sh/chart: {{ include "decidim-helm.chart" . }}
{{ include "decidim-helm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common web labels
*/}}
{{- define "decidim-helm.webLabels" -}}
helm.sh/chart: {{ include "decidim-helm.chart" . }}
{{ include "decidim-helm.webSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common sidekiq labels
*/}}
{{- define "decidim-helm.sdqLabels" -}}
helm.sh/chart: {{ include "decidim-helm.chart" . }}
{{ include "decidim-helm.sdqSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "decidim-helm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "decidim-helm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "decidim-helm.webSelectorLabels" -}}
app.kubernetes.io/name: {{ include "decidim-helm.name" . }}
app: {{ include "decidim-helm.webFullname" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "decidim-helm.sdqSelectorLabels" -}}
app.kubernetes.io/name: {{ include "decidim-helm.name" . }}
app: {{ include "decidim-helm.sdqFullname" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "decidim-helm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "decidim-helm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Web container port
*/}}
{{- define "decidim-helm.webContainerPort" -}}
{{- default 3000 .Values.containerPort }}
{{- end }}
