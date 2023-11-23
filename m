Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy0JV52J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F47FA3
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Nov 2023 08:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700756485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wspGvWvjSaUYwRwuRXVEd/03EhWXlKqTevCRJ0Mh7bE=;
	b=Cy0JV52JQ/GvLARCjhZbBYWooYX/APE0uaxeRHOxc+K61M2QSxP8aA1rV+7GSfXKGTz7Tz
	ni/xtFakcDmzpMZj86AqV9FyDKaBJiZNTJ4PcvXCpLW+4AhzXHPgbMXcvWVmNnpDZrsc3z
	4W0a6AZBhTv/ApiBJiJRoa3XPDsR7Z4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-EJxYhtpaN0mj10NGoT9o4w-1; Thu, 23 Nov 2023 11:21:24 -0500
X-MC-Unique: EJxYhtpaN0mj10NGoT9o4w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6757f3d7911so9936316d6.1
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Nov 2023 08:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700756483; x=1701361283;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wspGvWvjSaUYwRwuRXVEd/03EhWXlKqTevCRJ0Mh7bE=;
        b=heYogF4/ZmBfVorMJZbtJbmMceUFy2A3dOZmLzXD5RjaE5L3s2eQycmbdGJGLZjohh
         1lINRnkfMrcHtVjGk5rxKP8BkqiRnHKUXq2tqS2X07mpzjoEPQlbnKzmC77kDexmeUv5
         wR5FHITtwdmnj3psnVmvHw6waEH5791s8jEx1/oCaWp0CMwTQI4Ke7a3z6TcpapVycu3
         J7WZLgy0800Q9OdOG4J//tNvgwUDubNJ1sD+lDdP2umxfHT1rc6g0lijcRU6dtxcLE2w
         j4hsFSywKc42bJ09LqX/bOhIu8UEZXD5D9HPdV/b2vD1lEp1dlmXYzaI1ukF2YeB5u0O
         IcWA==
X-Gm-Message-State: AOJu0YwvV1DBM4PH0rKhP2JlQbTAqs9Up7rRDKXn8IIZlFZ9IT/bsVrZ
	hvFxVKBb0B4FKAvX6XxmYQyYw2B3dH1D/oPt/ZCn1XP59gwzoM79D741en8BTXTrkiGQDJXwQyo
	w4PldYQWyG4d2+y+vke+V/SJoI5N23PJWoYo=
X-Received: by 2002:a05:6214:2602:b0:679:d31a:83cd with SMTP id gu2-20020a056214260200b00679d31a83cdmr6701745qvb.60.1700756483465;
        Thu, 23 Nov 2023 08:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/O9027B8N2I/In6Zqb7uYvYFMp1A2etpDseScEhFB6ZMTAI+nzcBdgk7XwkKTfvuOI9RyHQ==
X-Received: by 2002:a05:6214:2602:b0:679:d31a:83cd with SMTP id gu2-20020a056214260200b00679d31a83cdmr6701729qvb.60.1700756483208;
        Thu, 23 Nov 2023 08:21:23 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id m2-20020ad45042000000b0067a10a23a9csm3388qvq.49.2023.11.23.08.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:21:22 -0800 (PST)
Date: Thu, 23 Nov 2023 11:20:57 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 2/3] rteval: Minor improvements to CpuList class
In-Reply-To: <20231123072436.270267-3-tglozar@redhat.com>
Message-ID: <7b393164-b0fa-5c2f-45f9-6289ad8813fc@redhat.com>
References: <20231123072436.270267-1-tglozar@redhat.com> <20231123072436.270267-3-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 23 Nov 2023, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> - Remove unnecessary if-else from online_file_exists
> - Use cpupath in online_file_exists
> - Check for cpu0 instead of cpu1 in online_file_exists

The reason we check cpu1 is that on some hardware where you can't turn off 
cpu0, the online file also doesn't exist even though it is available for 
other cpus. We only want to learn whether we can use it in general or not.

For example on my laptop

[jkacur@fionn rteval]$ ls /sys/devices/system/cpu/cpu0/online
ls: cannot access '/sys/devices/system/cpu/cpu0/online': No such file or 
directory
[jkacur@fionn rteval]$ ls /sys/devices/system/cpu/cpu1/online 
/sys/devices/system/cpu/cpu1/online

John

> - In is_online, remove check for n in cpuset and make it static
> - Mark also the remaining methods static since they do not rely on
> any fields of the class
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  rteval/systopology.py | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/rteval/systopology.py b/rteval/systopology.py
> index ea8e242..97d3dc4 100644
> --- a/rteval/systopology.py
> +++ b/rteval/systopology.py
> @@ -82,12 +82,14 @@ class CpuList:
>      def __len__(self):
>          return len(self.cpulist)
>  
> +    def getcpulist(self):
> +        """ return the list of cpus tracked """
> +        return self.cpulist
> +
>      @staticmethod
>      def online_file_exists():
>          """ Check whether machine / kernel is configured with online file """
> -        if os.path.exists('/sys/devices/system/cpu/cpu1/online'):
> -            return True
> -        return False
> +        return os.path.exists(os.path.join(CpuList.cpupath, "cpu0/online"))
>  
>      @staticmethod
>      def isolated_file_exists():
> @@ -147,14 +149,9 @@ class CpuList:
>                  result.append(a)
>          return [int(i) for i in list(set(result))]
>  
> -    def getcpulist(self):
> -        """ return the list of cpus tracked """
> -        return self.cpulist
> -
> -    def is_online(self, n):
> +    @staticmethod
> +    def is_online(n):
>          """ check whether cpu n is online """
> -        if n not in self.cpulist:
> -            raise RuntimeError(f"invalid cpu number {n}")
>          path = os.path.join(CpuList.cpupath, f'cpu{n}')
>  
>          # Some hardware doesn't allow cpu0 to be turned off
> @@ -163,16 +160,17 @@ class CpuList:
>  
>          return sysread(path, "online") == "1"
>  
> -    def online_cpulist(self, cpulist):
> +    @staticmethod
> +    def online_cpulist(cpulist):
>          """ Given a cpulist, return a cpulist of online cpus """
>          # This only works if the sys online files exist
> -        if not self.online_file_exists():
> +        if not CpuList.online_file_exists():
>              return cpulist
>          newlist = []
>          for cpu in cpulist:
> -            if not self.online_file_exists() and cpu == '0':
> +            if not CpuList.online_file_exists() and cpu == '0':
>                  newlist.append(cpu)
> -            elif self.is_online(int(cpu)):
> +            elif CpuList.is_online(int(cpu)):
>                  newlist.append(cpu)
>          return newlist
>  
> -- 
> 2.41.0
> 
> 
> 

