Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA37156E4
	for <linux-rt-users@vger.kernel.org>; Fri, 26 Apr 2024 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714157610; cv=none; b=YuDxeNj8EaHGefJvpVBsSL8rOvyVQM1j2PjyVNr6LblO/P17frOkCPzS1Mq/6nDoaLRhUVnmSkjGUCbixYG0YOGPYt6CSL45ZxgC0PAOBeWyLdrTPlmsxfXdxjo2/aZ+2/+scxfX2DbtL6WsPFaDjT8K7T5ne88JAE5GK2rzU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714157610; c=relaxed/simple;
	bh=2Bbylo2NV9TiVCpJkgFpeukPYTybo5Ktzw0hG2hx+Oo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XMjQ6JrK3erKdMImcQOXDH8Jvj98rZGG5Z8i8sJprVb4pvBCvQqBll39zQupQuCVLcu/XC40zy+tYfzieJHA54szNJ4MLwdKhuEBK5FCMLjuR2b0jYaXrU8SOwDauAnF+WelXLKe09g/RockZ/PAkF1Y7H372Spq9zv3TjGfn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2fC9ryU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2fC9ryU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714157607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MILJlSSGfp9N8zv7LJt0+yj/zPG/M4ZSyXc3gQULm/s=;
	b=V2fC9ryU5HtaaIIJXoVdNvXSYdVf1Tpe1Ej5Y4ugEeTB8+qLH+IzwhH3PHO0wnjnMH11+x
	69s7u4kBnXuaWUMMWyjsArke7Bt2+6LUYpQllgt+21SMw9zUYFI+uqyyabUKeFSVLGXhZw
	nUxXfHuWOy1iuqP3oufA7OQnWL1v2NQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-o8Q5ztulPvyimDqLlv2dRQ-1; Fri, 26 Apr 2024 14:53:26 -0400
X-MC-Unique: o8Q5ztulPvyimDqLlv2dRQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-439fcfca0a7so32748951cf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Apr 2024 11:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714157605; x=1714762405;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MILJlSSGfp9N8zv7LJt0+yj/zPG/M4ZSyXc3gQULm/s=;
        b=BZHx5PtVWS2szdR9yMzXV5F6qwei9L5TjawTTVkGlzdv0CTC+txOvKJOcf/zQDozv9
         k3cLX8KyxG1zeDhepg2EtqD8G0chwZNqTvZCN1jfQHW/K61QCiC5BAYnKPuiYENOF0vo
         e/AOF99DaXcFQNwOGlJStLTUsi1ksSRNlmZk2GNLMN3MnHI5rkNhivLgriUGrvMPwcRP
         PWHwhDSiZ0pLhTFDGtL8FwP7zYPIj4ZcBrFFtXD1hyvf5YuP9hJhRZ7QZ3w15N6Gcqfp
         tBZKiKbKybEHXXOwI6HSByGnvGuDZpZRf9KSENCWYvGRjyOIXBVv9koJMnq751spOHO5
         xXZw==
X-Gm-Message-State: AOJu0Yy8/i1EfI66btpI/t4yNrPXGZhRcq3K1EuFLAdB0oOc1dqie8DP
	RpbYlytLW5jBbzxZq2diYjeMI0PuMd7BLqkd9qKqc3kiYfP8VBJ9T/o0qC+G/2i239oC9fJ8njs
	sqrWDxSLwaf9H0aCh1fOvfvWeLGOc+/JguOPSC94zrJO/yn/G7pyU0lgUy1YZgqMUYoe+SwmNiS
	47+Nihwa+jriQ0U3hZoIpsQpuK0piQZLll5JmHa0H2z2/zew==
X-Received: by 2002:a05:622a:4a19:b0:434:b593:2d25 with SMTP id fv25-20020a05622a4a1900b00434b5932d25mr4620036qtb.66.1714157605608;
        Fri, 26 Apr 2024 11:53:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN8cX8nbqL2taqasFw+j0gQicwmLZ+rppICAQDHyrADEu2sNh0rsMOKQpMuNGC5NyFPl5lcQ==
X-Received: by 2002:a05:622a:4a19:b0:434:b593:2d25 with SMTP id fv25-20020a05622a4a1900b00434b5932d25mr4620013qtb.66.1714157605180;
        Fri, 26 Apr 2024 11:53:25 -0700 (PDT)
Received: from fionn ([74.12.5.183])
        by smtp.gmail.com with ESMTPSA id kq5-20020ac86185000000b0043a6cbd9025sm1020778qtb.75.2024.04.26.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 11:53:24 -0700 (PDT)
Date: Fri, 26 Apr 2024 14:53:15 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
cc: Clark Williams <williams@redhat.com>, 
    Daniel Bristot de Oliveria <bristot@redhat.com>, 
    Juri Lelli <juri.lelli@redhat.com>, 
    Kate Carcia Poulin <kcarcia@redhat.com>
Subject: Re: [PATCH] rteval: Add summary reporting for rteval
In-Reply-To: <20240426185008.225739-1-jkacur@redhat.com>
Message-ID: <9a5d8681-e077-dc2c-63ec-c1e24c74e6aa@redhat.com>
References: <20240426185008.225739-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 26 Apr 2024, John Kacur wrote:

> This adds an rteval section to the xsl file and generates a timerlat
> report at the end of a run. To use it edit your rteval.conf file
> to comment out cyclictest and uncomment timerlat
> 
> Another interesting thing you can do is uncomment both of them and
> get a report from both in one run.
> 
> You can also use this with the summary report, for example
> 
> rteval -Z rteval-20240426-3/summary.xml
> 
> will work with timerlat now. (or both cyclictest and timerlat at the
> same time.)
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  rteval.conf            |   1 +
>  rteval/rteval_text.xsl | 103 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 100 insertions(+), 4 deletions(-)
> 
> diff --git a/rteval.conf b/rteval.conf
> index 4c32fcf4d842..601410b51c28 100644
> --- a/rteval.conf
> +++ b/rteval.conf
> @@ -7,6 +7,7 @@ report_interval: 600
>  
>  [measurement]
>  cyclictest: module
> +# timerlat: module
>  
>  [loads]
>  kcompile:  module
> diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
> index f526526d4d49..1e9c0f0d26c5 100644
> --- a/rteval/rteval_text.xsl
> +++ b/rteval/rteval_text.xsl
> @@ -201,11 +201,11 @@
>      <!--                                                                        -->
>      <!--       select="cyclictest|new_foo_section|another_section"              -->
>      <!--                                                                        -->
> -    <xsl:apply-templates select="cyclictest|hwlatdetect[@format='1.0']|sysstat"/>
> +    <xsl:apply-templates select="cyclictest|timerlat|hwlatdetect[@format='1.0']|sysstat"/>
>      <xsl:text>&#10;</xsl:text>
>    </xsl:template>
>  
> -  <!-- Format the cyclic test section of the report -->
> +  <!-- Format the cyclictest section of the report -->
>    <xsl:template match="/rteval/Measurements/Profile/cyclictest">
>      <xsl:text>       Latency test&#10;</xsl:text>
>  
> @@ -237,7 +237,7 @@
>    </xsl:template>
>  
>  
> -  <!--  Format the CPU core section in the cyclict test part -->
> +  <!--  Format the CPU core section in the cyclictest part -->
>    <xsl:template match="/rteval/Measurements/Profile/cyclictest/core">
>      <xsl:text>          CPU core </xsl:text>
>      <xsl:value-of select="@id"/>
> @@ -300,6 +300,101 @@
>      <xsl:text>&#10;</xsl:text>
>    </xsl:template>
>  
> +  <!-- Format the timerlat section of the report -->
> +  <xsl:template match="/rteval/Measurements/Profile/timerlat">
> +    <xsl:text>       Latency test&#10;</xsl:text>
> +
> +    <xsl:text>          Started: </xsl:text>
> +    <xsl:value-of select="timestamps/runloop_start"/>
> +    <xsl:text>&#10;</xsl:text>
> +
> +    <xsl:text>          Stopped: </xsl:text>
> +    <xsl:value-of select="timestamps/runloop_stop"/>
> +    <xsl:text>&#10;</xsl:text>
> +
> +    <xsl:text>          Command: </xsl:text>
> +    <xsl:value-of select="@command_line"/>
> +    <xsl:text>&#10;&#10;</xsl:text>
> +
> +    <xsl:apply-templates select="abort_report"/>
> +
> +    <xsl:text>          System:  </xsl:text>
> +    <xsl:value-of select="system/@description"/>
> +    <xsl:text>&#10;</xsl:text>
> +
> +    <xsl:text>          Statistics: &#10;</xsl:text>
> +    <xsl:apply-templates select="system/statistics"/>
> +
> +    <!-- Add CPU core info and stats-->
> +    <xsl:apply-templates select="core">
> +      <xsl:sort select="@id" data-type="number"/>
> +    </xsl:apply-templates>
> +  </xsl:template>
> +
> +
> +  <!--  Format the CPU core section in the timerlat part -->
> +  <xsl:template match="/rteval/Measurements/Profile/timerlat/core">
> +    <xsl:text>          CPU core </xsl:text>
> +    <xsl:value-of select="@id"/>
> +    <xsl:text>       Priority: </xsl:text>
> +    <xsl:value-of select="@priority"/>
> +    <xsl:text>&#10;</xsl:text>
> +    <xsl:text>          Statistics: </xsl:text>
> +    <xsl:text>&#10;</xsl:text>
> +    <xsl:apply-templates select="statistics"/>
> +  </xsl:template>
> +
> +
> +  <!-- Generic formatting of statistics information -->
> +  <xsl:template match="/rteval/Measurements/Profile/timerlat/*/statistics">
> +    <xsl:text>            Samples:           </xsl:text>
> +    <xsl:value-of select="samples"/>
> +    <xsl:text>&#10;</xsl:text>
> +
> +    <xsl:if test="samples > 0">
> +      <xsl:text>            Mean:              </xsl:text>
> +      <xsl:value-of select="mean"/>
> +      <xsl:value-of select="mean/@unit"/>
> +      <xsl:text>&#10;</xsl:text>
> +
> +      <xsl:text>            Median:            </xsl:text>
> +      <xsl:value-of select="median"/>
> +      <xsl:value-of select="median/@unit"/>
> +      <xsl:text>&#10;</xsl:text>
> +
> +      <xsl:text>            Mode:              </xsl:text>
> +      <xsl:value-of select="mode"/>
> +      <xsl:value-of select="mode/@unit"/>
> +      <xsl:text>&#10;</xsl:text>
> +
> +      <xsl:text>            Range:             </xsl:text>
> +      <xsl:value-of select="range"/>
> +      <xsl:value-of select="range/@unit"/>
> +      <xsl:text>&#10;</xsl:text>
> +
> +      <xsl:text>            Min:               </xsl:text>
> +      <xsl:value-of select="minimum"/>
> +      <xsl:value-of select="minimum/@unit"/>
> +      <xsl:text>&#10;</xsl:text>
> +
> +      <xsl:text>            Max:               </xsl:text>
> +      <xsl:value-of select="maximum"/>
> +      <xsl:value-of select="maximum/@unit"/>
> +      <xsl:text>&#10;</xsl:text>
> +
> +      <xsl:text>            Mean Absolute Dev: </xsl:text>
> +      <xsl:value-of select="mean_absolute_deviation"/>
> +      <xsl:value-of select="mean_absolute_deviation/@unit"/>
> +      <xsl:text>&#10;</xsl:text>
> +
> +      <xsl:text>            Std.dev:           </xsl:text>
> +      <xsl:value-of select="standard_deviation"/>
> +      <xsl:value-of select="standard_deviation/@unit"/>
> +      <xsl:text>&#10;</xsl:text>
> +    </xsl:if>
> +    <xsl:text>&#10;</xsl:text>
> +  </xsl:template>
> +
>  
>    <!-- Format the hwlatdetect test section of the report -->
>    <xsl:template match="/rteval/Measurements/Profile/hwlatdetect[@format='1.0' and not(@aborted)]">
> @@ -340,7 +435,7 @@
>      <xsl:text>us&#10;</xsl:text>
>    </xsl:template>
>  
> -  <!-- Format the cyclic test section of the report -->
> +  <!-- Format the cyclictest section of the report -->
>    <xsl:template match="/rteval/Measurements/Profile/sysstat">
>      <xsl:text>       sysstat measurements&#10;</xsl:text>
>  
> -- 
> 2.44.0
> 
> 
Oops, I ammended the title to say,
"rteval: Add summary reporting for timerlat"

John

