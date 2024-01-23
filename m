Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58662109
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042173; cv=none; b=QVxx/Ct/6zNNJyGU4um8PPW2rnAcGyWXewfaU5XCjPcWas7yi0Z4yOzm91Vz+Pqg2TihbYA6dFEnwyVSrsmnOafQ5ukdEAmNt7Nkmq2nJohqjwQdWtXhtboBOcZTRqHurAqZect88/FxcVlcewObfJ15gXZzCUPzyicj/K9PCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042173; c=relaxed/simple;
	bh=338hjIbrRkxQnUYHJT8Nm+K0YfOKQtvp2ncb89FWgrA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aVobDZFIpboNz7WhIUdY0D6xHVb5IXhYSMzFP0laqPy1l7CiX2mWETzSHaam6Bf1/RscTcfoyo8g+ip05V9YAWuXvmPOvKriaPfqrL0EL4W20I8o4iDnideqSibpH7mtXAyOuLnSEsPI2dgo04ZBlnqcp0mqYN23/Zdc3+yde8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Di4hyX6L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Di4hyX6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706042171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nMFkE+AtfuU7UIFZsCImUacvuKyTYH720O3Xvd2ptN4=;
	b=Di4hyX6LamllzTeDB6F96Dw9zreLe4LGLuCMTjmyUA+XI50jWgsdMUn51405rEbymw+PXY
	8Mk7X8U7xh/zavmQQ4dqcWgZajQKzeSuKtx/QVqXLRvb2+gGF4g6g0kvC/Aisoiwk60dKu
	JDt4mjX6eynSoNJnzM4wzWzNZRLyuJc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-4D94E4VUM-6VjmX98ISiDA-1; Tue, 23 Jan 2024 15:36:09 -0500
X-MC-Unique: 4D94E4VUM-6VjmX98ISiDA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68578a962ddso48094726d6.0
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 12:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042169; x=1706646969;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMFkE+AtfuU7UIFZsCImUacvuKyTYH720O3Xvd2ptN4=;
        b=FZ62UjCmBUC1c7u/b6T/E17zedjViU2ZctqHrmmDNGf+8Keg47A0TSED8mx3dGaF6p
         PJaYXIzig1+U+PRMIb9NuGpMehQRRwSA7P4HKPYFuwG4iJxRUroTWMzB8X8mqLqaRH7l
         JqGjpIvZ2UWH/4Dh2XL39L1IuF9GESEBeVnk5FyN1BGLcf8CvA/0G5dOx/4clPznQz3w
         m+vA1dQFi6qgHV6FK1fIheQQn1ZoaPkYwFoxqjvhNgQJwqdigmQH45N5Q/7chMTle/p7
         LQSPbllapxxFLNxQnIoDfwWW4XW6pVSZUCj0uJDIGAsCwTDpmrGhtD7zy/weLk20raLl
         AHBg==
X-Gm-Message-State: AOJu0Yw0wec0/dXihKDOlaw+bAAIMbVikImO6ST7Gg9wbGDDeNAfOw0I
	cGd2YzYWeB6yL6YiGLRjTlQ6+4RZhrFvb/vVwi5fGHtQPi2CTdjAiYrFLpteKCwQabYT44bwg5P
	1BS3YMX62M03aOV1jwWloFZ6sKq8tgallWIdcYxhFxDJr+UDMGwlh5CH+fmgFlWaUfOhmYgGq
X-Received: by 2002:a05:6214:5089:b0:686:ab99:cceb with SMTP id kk9-20020a056214508900b00686ab99ccebmr486201qvb.12.1706042168936;
        Tue, 23 Jan 2024 12:36:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPBihCUft0NPkUCLE8B+8bgsrA0XqH54DYzG9Pvb1tmyZkl7NQEYH/OIEhexoMoUaEjBtOBQ==
X-Received: by 2002:a05:6214:5089:b0:686:ab99:cceb with SMTP id kk9-20020a056214508900b00686ab99ccebmr486193qvb.12.1706042168745;
        Tue, 23 Jan 2024 12:36:08 -0800 (PST)
Received: from fionn ([174.88.88.13])
        by smtp.gmail.com with ESMTPSA id e16-20020a37ac10000000b007816dc2ef52sm3405380qkm.8.2024.01.23.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:36:08 -0800 (PST)
Date: Tue, 23 Jan 2024 15:35:59 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Chris White <chwhite@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: Add interactive source-to-image Dockerfile
In-Reply-To: <20231204225840.17042-1-chwhite@redhat.com>
Message-ID: <66d90617-d862-3db6-a330-e260f65a4492@redhat.com>
References: <20231204225840.17042-1-chwhite@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 4 Dec 2023, Chris White wrote:

> This Dockerfile sets up a base image for rt-tests, copies the code,
> and installs it, providing an interactive container for testing the
> various applications packaged.
> 
> Signed-off-by: Chris White <chwhite@redhat.com>
> ---
>  Dockerfile | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Dockerfile
> 
> diff --git a/Dockerfile b/Dockerfile
> new file mode 100644
> index 0000000..92f680e
> --- /dev/null
> +++ b/Dockerfile
> @@ -0,0 +1,26 @@
> +# Use CentOS Stream 9 as base image
> +FROM centos:stream9
> +
> +# Install required packages for RT-Tests
> +RUN dnf -y update && \
> +    dnf install -y \
> +        gcc \
> +        make \
> +        numactl-devel \
> +        util-linux \
> +        git && \
> +    git clone https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git /opt/rt-tests && \
> +    cd /opt/rt-tests && \
> +    make && \
> +    make install && \
> +    dnf remove -y \
> +        git \
> +        make && \
> +    dnf clean all
> +
> +
> +# Set the working directory to the RT-Tests directory
> +WORKDIR /opt/rt-tests
> +
> +# Set the entrypoint to a shell
> +ENTRYPOINT ["/bin/bash"]
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

