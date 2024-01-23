Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17D3205
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042220; cv=none; b=ti7vrYx3Zxdlr4cs3KAWMsXit3tBCqbn/YrTdntwbdt57lP7gHt4w1PCxaxzcyl7THG5s6VITfJlPl7YXLteUITyeapnznjcM860cvgW/oxWSPaQ66jnJnImFOSkMXk23hFFjiopK2h0mFdVsjZzL/OBYUbqIV6nuEeVmfeiKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042220; c=relaxed/simple;
	bh=DlMkSmfwMpWpwrm/zxodyHHtb+R8m7ieCKZoyaKUwac=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IImHA8wKj1PbeLrYDZ0GanwvcRW06Sn3Slv3YuCMAzuBN1dCNgHPCmrpqqeoq8jwF28768On4H+gxMxXBhCOiXpArWsWZCtQighlaqOYT8v9ZtGHZfjh96hqkniiQXZeuAkxWWFNjRsD9pTMHKJTI8lvkzIlANQOdqsRDZD3K2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7CG68l1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7CG68l1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706042217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nq3eKx1/oxLvf95lBR86hTrrxrZbgJ4xtxawf1vFDoU=;
	b=I7CG68l1glmqGEq3FmDyJD0n+0/Vd5B2GrIoSk3LZRI07URO6YFmVHOA6Y6vVtOKbqLvLR
	d5AnMtQDDqy3xBevcl8P52XDtJ9doCsivFMUiNP5lSi2X6PWlPENJ7Mm3HvlxxHpKl6UoT
	Thxxq5KnhbwBAzEutXTNdyhGPiT+7pI=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-WKPqUSBQP06TYW_xLNgXkA-1; Tue, 23 Jan 2024 15:36:55 -0500
X-MC-Unique: WKPqUSBQP06TYW_xLNgXkA-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4bd5adf9e90so40151e0c.1
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Jan 2024 12:36:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042214; x=1706647014;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nq3eKx1/oxLvf95lBR86hTrrxrZbgJ4xtxawf1vFDoU=;
        b=YeKDcGRKr4pUvWrydccmvEx3XD82OgHlXl0YvbUUHQlISxZPsZEa4Dz3eCSPvYGB2D
         1U5wSeM6H1iqJNAMug422spw3seXUxJW/ZmGuLdMKTG6U7/VmyAfbg0AZ5eIJ80xIV4D
         zXVN53oVaYAkNnrqrr4ABxhi8jEUO7BivaBJZjDZzBJz6WR8Y9Kg6wXdX1yhOUEnxpiJ
         7Zcku9f48EOOsvp52lrw1mYan7bHWZ0ZkKS+mPJTKWwbqaL/gFN1Fovtu4tIeIqSCE2l
         JP7f0jlIf6O4GAKBvWnCTRpqw2zaIjrwI6qFLVrXa+h4D6dMb8OXpe3P1GrOSRzFfwQ+
         25ww==
X-Gm-Message-State: AOJu0Yw2oBDpzAuMhrgOWhbwyMLe66NxrRFWg+fM6RbhLlN9XQ/symFm
	e9EAzpYs1TAN7eW4e8FybsnN0KUSwt84vEDNz1XofMhYj5mN1BjKULxoJoxYVHqOpNBy9Ldv4c4
	mUFcSsemJD3hhXdTC44QwcnNSrBLwLjZ65DKAwxkLDQCYb8k2vVOfkgw2nchdEy/c0uAFkcBg
X-Received: by 2002:a05:6122:d91:b0:4b6:e6b6:7f4f with SMTP id bc17-20020a0561220d9100b004b6e6b67f4fmr3376639vkb.15.1706042214704;
        Tue, 23 Jan 2024 12:36:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyux8jjJpwAi+ol1cy1jJtKiUHXsYTS/rx/+erlmM4BSPEK1K6hUb08If1/HmtP8SVKVhkeg==
X-Received: by 2002:a05:6122:d91:b0:4b6:e6b6:7f4f with SMTP id bc17-20020a0561220d9100b004b6e6b67f4fmr3376628vkb.15.1706042214339;
        Tue, 23 Jan 2024 12:36:54 -0800 (PST)
Received: from fionn ([174.88.88.13])
        by smtp.gmail.com with ESMTPSA id j7-20020a0ceb07000000b00681092cb7b4sm3741783qvp.103.2024.01.23.12.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:36:54 -0800 (PST)
Date: Tue, 23 Jan 2024 15:36:45 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Chris White <chwhite@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rteval: Add Dockerfile README
In-Reply-To: <20240123191810.107-1-chwhite@redhat.com>
Message-ID: <c77026f7-5287-edac-cb7f-9adc97bce1ad@redhat.com>
References: <20240123191810.107-1-chwhite@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 23 Jan 2024, Chris White wrote:

> Add README.md for Docker setup, covering build and test instructions
> in a containerized environment.
> 
> Signed-off-by: Chris White <chwhite@redhat.com>
> ---
>  README-Dockerfile | 49 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 README-Dockerfile
> 
> diff --git a/README-Dockerfile b/README-Dockerfile
> new file mode 100644
> index 0000000..95da6d8
> --- /dev/null
> +++ b/README-Dockerfile
> @@ -0,0 +1,49 @@
> +
> +# README-Dockerfile-rteval
> +
> +## Introduction
> +This README provides detailed instructions for setting up an rteval container using Docker or Podman. This Dockerfile is designed to pull the latest local copy of your code, along with any modifications you've made, and compile it into a container image for testing purposes. This approach offers an OS-agnostic method for testing your changes, suitable for semi-modern host operating systems. The containerized environment of rteval ensures consistent and reproducible test results across different systems.
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
> +  - For Podman: `sudo podman build -t rteval-upstream .`
> +  - For Docker: `sudo docker build -t rteval-upstream .`
> +
> +## Usage
> +### Run the Container
> +- Start the container in privileged mode. This container will drop you directly into an interactive shell. Run the following command to start the container and drop into an interactive shell:
> +  - For Podman: `sudo podman run -it --privileged rteval-upstream`
> +  - For Docker: `sudo docker run -it --privileged rteval-upstream`
> +- This will create a long lasting container. In order to use it again (say after a reboot), you need to start and exec into the container to get yourself back into the shell:
> +  - For Podman: 
> +    - `sudo podman start rteval-upstream`
> +    - `sudo podman exec -it rteval-upstream /bin/bash`
> +  - For Docker: 
> +    - `sudo docker start rteval-upstream`
> +    - `sudo docker exec -it rteval-upstream /bin/bash`
> +- And to clean up and remove your container so you can test a new one:
> +  - For Podman: `sudo podman rm -f rteval-upstream`
> +  - For Docker: `sudo docker rm -f rteval-upstream`
> +- Please note that the above command does not cleanup the container when you are done. It can be useful to run a single use container when trying to only test a quick change and remove the container afterwards. To run a a single use container that removes itself immediately after you exit the shell, run the following commands with the `--rm` option:
> +  - For Podman: `sudo podman run -it --rm --privileged rteval-upstream`
> +  - For Docker: `sudo docker run -it --rm --privileged rteval-upstream`
> +  
> +
> +### Test rteval Build
> +- Inside the container, test the 'rteval' build:
> +  - Command: `rteval -d 1s`
> +
> +## Conclusion
> +Follow these detailed steps for a successful rteval container setup using Docker or Podman.
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

