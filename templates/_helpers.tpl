{{/*
Expand the name of the chart.
*/}}
{{- define "..name" -}}
    {{- default .Chart.Name .Values.client.name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "..chart" -}}
    {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "..fullname" -}}
    {{- if .Values.client.fullname }}
        {{- .Values.client.fullname | trunc 63 | trimSuffix "-" }}
    {{- else }}
        {{- $name := default .Chart.Name .Values.client.name }}
        {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
    {{- end }}
{{- end }}

{{/*
Create a default fully qualified web app name.
We truncate at 59 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "..webFullname" -}}
    {{- if .Values.webFullnameOverride }}
        {{- .Values.web.fullname | trunc 59 | trimSuffix "-" }}
    {{- else }}
        {{- $name := default .Chart.Name .Values.web.name }}
        {{- printf "%s-%s-%s" .Release.Name "web" $name | trunc 59 | trimSuffix "-" }}
    {{- end }}
{{- end }}

{{/*
Create a default fully qualified sidekiq app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "..sdqfullname" -}}
    {{- if .Values.sidekiq.fullname }}
        {{- .Values.sidekiq.fullname | trunc 59 | trimSuffix "-" }}
    {{- else }}
        {{- $name := default .Chart.Name .Values.sidekiq.name }}
        {{- printf "%s-%s-%s" .Release.Name "sdq" $name | trunc 59 | trimSuffix "-" }}
    {{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "..labels" -}}
        helm.sh/chart: {{ include "..chart" . }}
        {{ include "..selectorLabels" . }}
    {{- if .Chart.AppVersion }}
        app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
    {{- end }}
        app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common web labels
*/}}
{{- define "..webLabels" -}}
        helm.sh/chart: {{ include "..chart" . }}
        {{ include "..webSelectorLabels" . }}
    {{- if .Chart.AppVersion }}
        app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
    {{- end }}
        app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common sidekiq labels
*/}}
{{- define "..sdqLabels" -}}
        helm.sh/chart: {{ include "..chart" . }}
        {{ include "..sdqSelectorLabels" . }}
    {{- if .Chart.AppVersion }}
        app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
    {{- end }}
        app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "..selectorLabels" -}}
        app.kubernetes.io/name: {{ include "..name" . }}
        app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector web labels
*/}}
{{- define "..webSelectorLabels" -}}
        app.kubernetes.io/name: {{ include "..name" . }}
        app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector sidekiq labels
*/}}
{{- define "..sdqSelectorLabels" -}}
        app.kubernetes.io/name: {{ include "..name" . }}
        app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the web service account to use
*/}}
{{- define "..serviceAccountName" -}}
    {{- if .Values.serviceAccount.create }}
        {{- default (include "..fullname" .) .Values.serviceAccount.name }}
    {{- else }}
        {{- default "default" .Values.serviceAccount.name }}
    {{- end }}
{{- end }}


{{/*
Web container port
*/}}
{{- define "..webContainerPort" -}}
    {{- default 3000 .Values.containerPort }}
{{- end }}
