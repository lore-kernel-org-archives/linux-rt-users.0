Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E951FD1
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042139; cv=none; b=jqn6uFoJnPIFEcKIDC/vhOxXmCbdy4MD4TRqJLOp25IaYiOjLizBZ8Fr7cP3f1+8W+VhuL/S2uf4h2Wmh/aodM6ODfuDiI3ooKVKH4db/mOLAk2akteTtl9lB95wECaxzU2HM8pm29dHvRZxvrvJnnLH5zUt9u4sbneP11puTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042139; c=relaxed/simple;
	bh=Yow0PCCUokWNkX4unT5HgmqTCavAlqiaUHtvqmx+i7E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QV0lLcnueOWruOM5yKEwzjcZ4JptCb0TQEqaNYwQ3FfcNrpiI9ViMfzmZvnPAz9HvvZ4Mf6n5X4ktPTddOSG+TuY0etPFf1grz/t5n78zAHT+vVuFopSmPKsguJtFZimVEMvQRl9Jyf+dUtOcKQnVPy7ua5mqkeEFJjhRz8E9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UypZhQ74; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UypZhQ74"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706042136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bgOxhouOAO5fcUydBT+qADF04/ca0oNLIjSt5jC87Lg=;
	b=UypZhQ74ukcswHqwl2xkNzetPYmVHXa4KhBvLwfO7ipCCkDTeGQc7iJgPaHbVfWHi/qNIa
	iORi5EAtMeCTwYNvavOFQTR8x1zsZw/PyiUGgUMXI0XtB5Z7XPM7qJsYg45dn7B83sNTl5
	6gzYqVnMf0SpDRuu+WvL7lfBg0XCFmE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-FzN1XcWCPRSDjQGM9GNsbA-1; Tue, 23 Jan 2024 15:35:35 -0500
X-MC-Unique: FzN1XcWCPRSDjQGM9GNsbA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-680c651928eso74857126d6.2
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 12:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042134; x=1706646934;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bgOxhouOAO5fcUydBT+qADF04/ca0oNLIjSt5jC87Lg=;
        b=E7pjY9CwsxBzpzHHSAdYxXVrajdgKAAavb4uMdIilmEG23Nl9Y6N1JAqWUWLqDoQIH
         iN6Aq99ltC5RTYjMlviMBCdFgN47al0Z2TJCABvZtqtogqJHH0tEpUHI8VdBK2/WtfK2
         Mt1gAi3iX1Yvvy9kDm6NGM70dsF4preRBT2tQRP33xGHnwGX5znEw95bUNGBzTRGAGMG
         GirlRp86aQn6M9KiST9DJMo680OTM/1p7NVtRzG940t/PDKKjYz92mqB0SDJ1ZHXkq2W
         +Vriz0IGlAsgf3PQeDEowhnoGiTU2TgIiJfKk7cGm0nWs8d+NRY9t0ithl7iAFDPksSf
         irLA==
X-Gm-Message-State: AOJu0YxdtbydDoV6ND4vR61S1EOTqbIIfvMa/ncCUQhFGxZamRX0D4uM
	+pY4VROzYL3xU9eKu3iXI1ZjWREItIamOUjRhO/jgGeKPuLMiqHNqLCQtPN20esyRnSekKxBSsJ
	Ly1fUSCSd2fMN8jH8fuLR5uvBrAy2+obErVBp+6zEl6g2TR1YVnZ0JCmymIAbqzurD91yyaAa
X-Received: by 2002:ad4:5ce7:0:b0:686:309e:14d2 with SMTP id iv7-20020ad45ce7000000b00686309e14d2mr1927057qvb.119.1706042134721;
        Tue, 23 Jan 2024 12:35:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIDthxVBS//OYkPDCEpUm8T+GdEJIrlKinGG4ZXG6AgCvDDu9HD5UT3l4r36bQDoBzTLpFKQ==
X-Received: by 2002:ad4:5ce7:0:b0:686:309e:14d2 with SMTP id iv7-20020ad45ce7000000b00686309e14d2mr1927051qvb.119.1706042134454;
        Tue, 23 Jan 2024 12:35:34 -0800 (PST)
Received: from fionn ([174.88.88.13])
        by smtp.gmail.com with ESMTPSA id lr7-20020a0562145bc700b006869485d9eesm1940102qvb.82.2024.01.23.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:35:34 -0800 (PST)
Date: Tue, 23 Jan 2024 15:35:25 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Chris White <chwhite@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Add interactive source-to-image Dockerfile
In-Reply-To: <20231204203416.16713-1-chwhite@redhat.com>
Message-ID: <bed0d3cc-9707-fa2d-0eb1-ff5c26de40f3@redhat.com>
References: <20231204203416.16713-1-chwhite@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 4 Dec 2023, Chris White wrote:

> This Dockerfile sets up a base image for rteval, copies the code,
> and installs it, providing an interactive container for testing
> rteval directly.
> 
> Signed-off-by: Chris White <chwhite@redhat.com>
> ---
>  .dockerignore |  1 +
>  Dockerfile    | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
>  create mode 100644 .dockerignore
>  create mode 100644 Dockerfile
> 
> diff --git a/.dockerignore b/.dockerignore
> new file mode 100644
> index 0000000..2d2ecd6
> --- /dev/null
> +++ b/.dockerignore
> @@ -0,0 +1 @@
> +.git/
> diff --git a/Dockerfile b/Dockerfile
> new file mode 100644
> index 0000000..45f6434
> --- /dev/null
> +++ b/Dockerfile
> @@ -0,0 +1,69 @@
> +# Use CentOS Stream 9 as base image
> +FROM centos:stream9
> +
> +ARG KERNEL_VERSION=linux-6.6.1.tar.xz
> +
> +
> +# Copy current directory to /opt/rteval/
> +COPY . /opt/rteval/
> +
> +# Install everything in one layer to shrink the image size
> +# 1: Install needed dependencies and pull kernel source
> +# 2: install rteval and fix bad symlink
> +# 3: Remove uneeded packages and shrink the image
> +RUN dnf -y update && \
> +    dnf install -y \
> +        python3-devel \
> +        python3-lxml \
> +        python3-libxml2 \
> +        python3-dmidecode \
> +        python3-requests \
> +        realtime-tests \
> +        sysstat \
> +        xz \
> +        bzip2 \
> +        tar \
> +        gzip \
> +        m4 \
> +        make \
> +        gawk \
> +        kernel-headers \
> +        sos \
> +        numactl \
> +        gcc \
> +        binutils \
> +        gcc-c++ \
> +        flex \
> +        bison \
> +        bc \
> +        elfutils \
> +        elfutils-libelf-devel \
> +        openssl \
> +        openssl-devel \
> +        stress-ng \
> +        perl-interpreter \
> +        perl-devel \
> +        perl-generators \
> +        libmpc \
> +        libmpc-devel \
> +        dwarves \
> +        wget \
> +        procps-ng && \
> +    cd /opt/rteval && \
> +    wget -P loadsource https://www.kernel.org/pub/linux/kernel/v6.x/${KERNEL_VERSION} && \
> +    make install && \
> +    make clean && \
> +    rm -f /usr/local/bin/rteval && \
> +    ln -s /opt/rteval/rteval-cmd /usr/bin/rteval && \
> +    dnf remove -y \
> +        gcc-c++ \
> +        python3-devel \
> +        perl-devel && \
> +    dnf clean all
> +
> +
> +# Set the working directory to /root
> +WORKDIR /root
> +
> +# Set the entrypoint to a shell
> +ENTRYPOINT ["/bin/bash"]
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

