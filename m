Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA37823AF
	for <linux-rt-users@vger.kernel.org>; Wed,  7 Aug 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043140; cv=none; b=YC/T99eGlKq3ms2WcpJ4/bThp2J/AtlYzZ2Pi6Uad2tFBcScfhiCMoEu07y2sfzZpUWSqfmQWSGtIROTuhuaxAN7Po5Ad6H7G+C5uTnSDEN0fL06sX9cF5IYxo/LkF6QaNkO39qqfTv1q23XfEGidsOlM+hJfxyLM71CxkPC5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043140; c=relaxed/simple;
	bh=DlC6eqaN+uCzO/uWv/zGvtdL3067C7wC3TP6SjZORRY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=myxoOw7QF/VAzSIGtNsJBfWdCFaquOcL3yGSw0zHPjCtUBTc2rxrxQmb0XfD1BDOpQ2dl+cUgP9Q/NtchPlcugPMEwaNiyEOuK+OCwrTvOCqg49Ue7k9dOITqjIAk9AtXh1g3I64qq3i0iGrcu2nr55yYxHPOK+NSOWv6Cvf2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZdWgPXu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZdWgPXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723043137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E/+zlBjyjRdXhZxtNMCVQXAOoBdnGiVbz8j4/SfqNd8=;
	b=dZdWgPXuTc91mnAxuHRUmuSz4U5qy2/4KKI43cN9+OuBT0rEYQprhRfE2xkiDdlOne4G68
	1W6aiOc4v01ZXSJM5HDDrOSNrlZuZ2pZTAoJQt+fQvkCUnUoU7ov3v25ZBjuWw/2bd+IYj
	Xwu6SAaEEcDItHROG1f8BV8V4XwTTm0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-rLtV5Z0tMbSdHmi2pieU0g-1; Wed, 07 Aug 2024 11:05:36 -0400
X-MC-Unique: rLtV5Z0tMbSdHmi2pieU0g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1d06f8e78so212964885a.3
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Aug 2024 08:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723043136; x=1723647936;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/+zlBjyjRdXhZxtNMCVQXAOoBdnGiVbz8j4/SfqNd8=;
        b=O/qBMAY6PaO8AROMUSkR2hX3AKv0t01UW6mdoUqrWggyB4ayRGzxR+B3xc9uexycoP
         HqGmZiONU4EJbuCnGl379Pxm6L6Domyu69eZ1lVxTXHNXk6B/HTvh5od9ON626CDU4GX
         to7/cfm9KwTeaZWscFCMGLdtCXhhv0fQVnKYQFsnJOj0bbGfHNrpsOrXl/eL8sWZqSGw
         mXvVaOKlbO1WJqh63NLShIcDBaxHz3FSi1rn1nISaAB7jOxkjaAW0imC/2VjqPteijSE
         kcpTFVr+HGr7vEoIfm6VbYn4UsjQTX2zX+/pp2ixwmSXltk/Gu/RvJO95916q77E9yhz
         SiHg==
X-Gm-Message-State: AOJu0YzY9VCmkWGMAl7baNPIqaxMoYQMZEnBVIwmB6rDYYra8h8PzzP+
	SJsSUuzcx0hSYJzZ0yDOYNG6ckVQwvwo2dhf99lVK3sltlmSAGP6Z77iBIkoorpk3m1Ea4XSDjH
	PPs1CSxFA2c2c9NUDbl3yZQsbN96f211N+M8Gvefy/9HP1WNMopnzvUj/wU/Q/cGG
X-Received: by 2002:a05:620a:2988:b0:79f:776:a9f2 with SMTP id af79cd13be357-7a34ef9e509mr1952751485a.56.1723043135964;
        Wed, 07 Aug 2024 08:05:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAq8Bgq66dhsW5qROotH5h0bp5QQTIP0YNdggz50VYNsoqwvLEjw5r+6Tnv3haTPb4Wdkb2g==
X-Received: by 2002:a05:620a:2988:b0:79f:776:a9f2 with SMTP id af79cd13be357-7a34ef9e509mr1952748785a.56.1723043135569;
        Wed, 07 Aug 2024 08:05:35 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785f190csm68061085a.57.2024.08.07.08.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:05:35 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:05:33 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Add tuned state to rteval text report
In-Reply-To: <20240807063333.258868-1-tglozar@redhat.com>
Message-ID: <ce2060af-07c9-ddef-3cea-1a12bb6d228e@redhat.com>
References: <20240807063333.258868-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 7 Aug 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> Add a section "Tuned state" to the text report generated by rteval. Show
> tuned active state if tuned is present, otherwise, show a message that
> tuned is not present. If the active state is known, show also the
> verification result.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/rteval_text.xsl | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
> index 96846aa..70f3e0f 100644
> --- a/rteval/rteval_text.xsl
> +++ b/rteval/rteval_text.xsl
> @@ -143,6 +143,22 @@
>        </xsl:when>
>        <xsl:otherwise>(unknown)</xsl:otherwise>
>      </xsl:choose>
> +    <xsl:text>&#10;</xsl:text>
> +
> +    <xsl:text>   Tuned state:  </xsl:text>
> +    <xsl:choose>
> +      <xsl:when test="SystemInfo/Tuned/@present='1'">
> +        <xsl:value-of select="SystemInfo/Tuned/active_profile"/>
> +        <xsl:text> profile</xsl:text>
> +          <xsl:if test="SystemInfo/Tuned/active_profile != 'unknown'">
> +            <xsl:text>, verification: </xsl:text>
> +            <xsl:value-of select="SystemInfo/Tuned/verified"/>
> +          </xsl:if>
> +        </xsl:when>
> +        <xsl:otherwise>
> +          <xsl:text>not present</xsl:text>
> +        </xsl:otherwise>
> +    </xsl:choose>
>      <xsl:text>&#10;&#10;</xsl:text>
>     
>      <xsl:text>   System load:&#10;</xsl:text>
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

