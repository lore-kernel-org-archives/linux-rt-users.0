Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43647210F
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042251; cv=none; b=ToBbE3oXzNn7oM7V31SY2sYW+QMuR5UnrNvhXjOMGPJT7AD64c2AqfHAHpxPx3aLYGV12kVOjBpt6QWIboXp2/xWEpJpRSdqwVufUqEly3kVEYXIy8Qlp8v7lkWQ+AsXMR2QElue5WK9FHBPENcsfsGMAMrIHaKUnYMHZNCXUWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042251; c=relaxed/simple;
	bh=iz/nlMuZgbY5VEGb6pyJd3hPH7gu+HRuSlDQIY224vI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RFB9KajmJYpAkRMGH6pBulHYYvgMjExcaqJhNq5Hi2GkkqQTQHN5VsPsBkz8I+4KPalQEb+1/2hICp+AXgY5qnGPQJkOG0UTU+dCJl2i+ZKTg9e3T5qSkc8HK4DtApP6UnhQTsMhtIpWNja8k1oNJIJcmZUX+lLxXrCwdREpc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6tPdC5Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6tPdC5Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706042249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Wkyz5jRGcBLqXUNJmaPwKz4s7D9LJOqTS3Ig2xQXL4=;
	b=B6tPdC5ZmkyeEj+r/BBecy1G5z1kNTnotHZKvbw+o/Auh8k8/+CgrmPQTupPw0Lj9zlDJN
	YZ3ItH9uR3W2TUfvWrgc9v4uLbVDvB3Uyy2Aw2TJuYWKH361Fsc47S2yCt48oQON33zJnW
	7Y1UDbbS/x9zAjGnen7zGjsiviZ3cGQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-QuaQMOoUOtOEqI_iuACTrA-1; Tue, 23 Jan 2024 15:37:27 -0500
X-MC-Unique: QuaQMOoUOtOEqI_iuACTrA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78389fe6defso822364785a.1
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 12:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042247; x=1706647047;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Wkyz5jRGcBLqXUNJmaPwKz4s7D9LJOqTS3Ig2xQXL4=;
        b=N9kUvw1+Xe1PGNEtVIDgNApxW5yXWbuqcmEdPM1u1NwQgIXC/adtD89PgAB9YsmyC5
         Wo3AlkyuO3TLOFBhvk83MMQDmHw556usiV20iR0MSXM7xsL4pJ+Q4N6LqErKHVg/IQdu
         W3c41jbx3APwkdTPs3yT7d7rxh6x/juG2U6Ari5UmCyoeUUFgxNtRjxUzXYCGpc7gz5i
         KiW/ICnVIJFR/w2sOQurQry8EFp0kMzrKV4DMQo8ljiR7OCZYBXizPIPTjLYO6rkuTGU
         c78yVoL/u9lfNW9EtSIVCKEgx/wtvaI/v2wlSyQQLqP420d4hWzUQVoD0mm3o6wrDazw
         ZGtw==
X-Gm-Message-State: AOJu0YwjValc4Z2zX3o728z2i0rKe0wmRgY4Qe5WpXndgttpw0r5a/Ko
	uvueryT2aPwA0Zy8KNBHP3IMs4QTrLHpUIKkVZP/qQzWd/SzA2oA4zJbOLxIrozz0DJ/7x5a4d2
	Z64whO2G97srdzIhHo2J6MXdtWsDDMtrM+BKgPO0zonwrX+UPp5ueVyc/2wmKLWAk
X-Received: by 2002:a05:620a:124f:b0:783:8c80:a9c4 with SMTP id a15-20020a05620a124f00b007838c80a9c4mr7662667qkl.84.1706042246999;
        Tue, 23 Jan 2024 12:37:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUOncdE5cc7neN4kbHSiPQbaOCeJzFjD/oe5J8DM/zWP6aWV6xipv289vNaYZVus1RwmukcQ==
X-Received: by 2002:a05:620a:124f:b0:783:8c80:a9c4 with SMTP id a15-20020a05620a124f00b007838c80a9c4mr7662661qkl.84.1706042246751;
        Tue, 23 Jan 2024 12:37:26 -0800 (PST)
Received: from fionn ([174.88.88.13])
        by smtp.gmail.com with ESMTPSA id y9-20020a05620a44c900b007831f8c5aeasm3374621qkp.55.2024.01.23.12.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:37:26 -0800 (PST)
Date: Tue, 23 Jan 2024 15:37:17 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Chris White <chwhite@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: Add Dockerfile README
In-Reply-To: <20240123195336.167-1-chwhite@redhat.com>
Message-ID: <159e3b94-3917-2bf5-f8d8-b323b813abbc@redhat.com>
References: <20240123195336.167-1-chwhite@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 23 Jan 2024, Chris White wrote:

> Add README detailing Docker setup for building and testing
> rt-tests in a containerized environment.
> 
> Signed-off-by: Chris White <chwhite@redhat.com>
> ---
>  README-Dockerfile | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 README-Dockerfile
> 
> diff --git a/README-Dockerfile b/README-Dockerfile
> new file mode 100644
> index 0000000..fc6ec85
> --- /dev/null
> +++ b/README-Dockerfile
> @@ -0,0 +1,49 @@
> +1
> +# README-Dockerfile-rt-tests
> +
> +## Introduction
> +This README provides detailed instructions for setting up an rt-tests container using Docker or Podman. This Dockerfile will pull a current copy of your code (plus all of your changes) and compile it into a container image for you to test with. This will give you an imbiguous way to test your changes, assuming you are running on a semi-modern host OS. The rt-tests container can be used to test any of the subpackages found under the rt-tests project, but is mainly intended for hwlatdetect and cyclictest.
> +
> +## Prerequisites
> +- Docker or Podman installed on your system.
> +
> +## Installation
> +### Prepare Your Environment
> +- For EPEL systems (Fedora, CentOS, RHEL):
> +  - Install Podman: `sudo dnf install podman -y`
> +- For Debian-based systems (Ubuntu):
> +  - Install Docker: `sudo apt-get update && sudo apt-get install docker.io -y`
> +  - Alternatively, install Podman: `sudo apt-get update && sudo apt-get install podman -y`
> +
> +### Build the Container
> +- Navigate to the root directory of the 'rteval'
> +- Build the container image named 'rteval-upstream':
> +  - For Podman: `sudo podman build -t rt-tests-upstream .`
> +  - For Docker: `sudo docker build -t rt-tests-upstream .`
> +
> +## Usage
> +### Run the Container
> +- Start the container in privileged mode:
> +  - For Podman: `sudo podman run -it --privileged rt-tests-upstream`
> +  - For Docker: `sudo docker run -it --privileged rt-tests-upstream`
> +- This will create a long lasting container. In order to use it again (say after a reboot), you need to start and exec into the container to get yourself back into the shell:
> +  - For Podman: 
> +    - `sudo podman start rt-tests-upstream`
> +    - `sudo podman exec -it rt-tests-upstream /bin/bash`
> +  - For Docker: 
> +    - `sudo docker start rt-tests-upstream`
> +    - `sudo docker exec -it rt-tests-upstream /bin/bash`
> +- And to clean up and remove your container so you can test a new one:
> +  - For Podman: `sudo podman rm -f rt-tests-upstream`
> +  - For Docker: `sudo docker rm -f rt-tests-upstream`
> +- Please note that the above command does not cleanup the container when you are done. It can be useful to run a single use container when trying to only test a quick change and remove the container afterwards. To run a a single use container that removes itself immediately after you exit the shell, run the following commands with the `--rm` option:
> +  - For Podman: `sudo podman run -it --rm --privileged rt-tests-upstream`
> +  - For Docker: `sudo docker run -it --rm --privileged rt-tests-upstream`  
> +
> +### Test rteval Build
> +- Inside the container, test one of the rt-tests packages you just built: 
> +  - Command: `cyclictest -D 1s`
> +  - Command: `hwlatdetect --duration 1`
> +
> +## Conclusion
> +Follow these detailed steps for a successful rt-tests container setup using Docker or Podman.
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

