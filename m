Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D531DE3B6
	for <linux-rt-users@vger.kernel.org>; Mon, 28 Oct 2024 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128885; cv=none; b=iiFSfNKFG99e3r1Rh7HqNfCz+VATltRv3q//i5eFaQeWvfK5eaXZ0lxt16CN+/6CwjQ2l5ETLhc+lopedaHHuO44cPePUGKNElG4S4GUD8Y4HykIErZjXhz7sm6oSth4T5ofprKJ8Q7NW8NVZfZvJTEmdNyntOE0hSsyvHoycPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128885; c=relaxed/simple;
	bh=xpxXMGA22ieNMbrc+RpbMMIvKodStlGMiDgHMwJsG5I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WxbokZ1d4FOaN5dAYljRAdQ/Dma9StPm3MG8MdbGqbu8gKEUOKs6+p3Vm+lbKV/1doCZ/aG31+eZvcJJa50JXIzYnzSNcpqfX5lPRIqO8vkk2ajuBomSUwEevPvSiObGO0w0MyficwCAZZmJ1U7q6R1W/lF37Uor7lINq8V1vwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q3dKCBTz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3dKCBTz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730128882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ughxGZKCWZRZCa9vJgz8c9zlUywEmW3+B4CHoH7TF60=;
	b=Q3dKCBTz4PTCElyvIVd9bC+Guefy4ERvglWpftvGSvRUPCR0Iaqu8a90I1VjL/9pJgtIMR
	grb8cND1qPPCM7MnQureE1/b+SPhkrmp/xciIsdqGzEZj90L6MQPc+5TUnOx0MOcf63m9o
	7YKLNb1wzy1fX4SNIzMkcEKhLSpE6OY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-rc-XVutzO6O6RMkWVlSrtA-1; Mon, 28 Oct 2024 11:21:20 -0400
X-MC-Unique: rc-XVutzO6O6RMkWVlSrtA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbe6ad0154so69023466d6.0
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Oct 2024 08:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128880; x=1730733680;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ughxGZKCWZRZCa9vJgz8c9zlUywEmW3+B4CHoH7TF60=;
        b=tL6cq274GN1W8T/3PacJR/S5AsJ7hJa5SN9SFZHmHE2vXDUBaehH011I22zwqs8LDR
         EQxrcBTtFv/nZbYnBE5eE/czX5/bWS6ufWqjH2WXTyEs53x1Bs4QPDHYQC+CPLkMcfDd
         BnEPoo6Co6LT9VNIQTOCTBHgm5XAMM+4GTaF2/b2elkbKE8U0+dIUoO15EFzQejc+0Hy
         Qjvean623jsekl7NU/txADzaIr0KWvNaOjZgly9+w+GYO4Dg6gnV6h6buq+ZS7wT8BY7
         fHCXjx7io4ytr57H87xk0a2OXWR803dSeVMdcMIWIQvYvn4FXYxBwXeTM6St9lMd9i/r
         cm8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm9NuMwUl9RcobbaIafOs+pZUe/H6y6w2NnzQCklEZCmdVUE31VbEV7CWab8JL/DgYyuwNdPmwzdH9IiiKYw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywff1y0aWOnuAJsKDENNOrKnfddbQFUQ1XSZf0HSM8xjfVZPBY4
	CJ3ppxqaKZRxHqHQpLU9B9OLhUNWnf+Ub4e6m9k29wextDf6LjrfrUS5ejmqVyV8vBaFZDhuSjm
	Ss+YUplsqvE1Z2InhXqK6nJts1iuhLBijlRKVXeJ9QAbz3Et4fgDk0xKlwQ3Wvulm
X-Received: by 2002:a05:6214:3d85:b0:6d1:8346:9dbf with SMTP id 6a1803df08f44-6d185863b90mr171820506d6.42.1730128879806;
        Mon, 28 Oct 2024 08:21:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY+ijdsYtmbxClUXvih75i8n22TzBgnJuJjDjkLPmlbP56oASlCnW7/uGl7Mxmo2xAVYGmag==
X-Received: by 2002:a05:6214:3d85:b0:6d1:8346:9dbf with SMTP id 6a1803df08f44-6d185863b90mr171820246d6.42.1730128879505;
        Mon, 28 Oct 2024 08:21:19 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a0980csm33121986d6.84.2024.10.28.08.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 08:21:19 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:21:18 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, 
    linux-rt-users <linux-rt-users@vger.kernel.org>, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] tuna: Fix string syntax warnings with raw strings
In-Reply-To: <20241025190146.149123-1-jwyatt@redhat.com>
Message-ID: <9960ad89-8c0e-3588-2726-4129440fe5cb@redhat.com>
References: <20241025190146.149123-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 25 Oct 2024, John B. Wyatt IV wrote:

> tuna save <filename> allows you to save your kthreads tunables to
> a file to be used by rtctl. There were several backslashes that produce
> an error that pylint and Python (at least 3.12) gives a `SyntaxWarning:
> invalid escape sequence`.
> 
> Convert the strings written to the file with raw strings to resolve the
> warnings.
> 
> Tested by comparing the diffs of the files outputted by save.
> 
> Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> ---
>  tuna/tuna.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tuna/tuna.py b/tuna/tuna.py
> index bd678e2..2dbc6cb 100755
> --- a/tuna/tuna.py
> +++ b/tuna/tuna.py
> @@ -669,7 +669,8 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
>  # The regex is matched against process names as printed by "ps -eo cmd".
>  
>  ''' % filename)
> -    f.write("kthreads:*:1:*:\[.*\]$\n\n")
> +    f.write(r"kthreads:*:1:*:\[.*\]$")
> +    f.write("\n\n")

You can concatenate the raw string with the new lines like this, so that 
we don't increase the number of lines

f.write(r"kthreads:*:1:*:\[.*\]$" + "\n\n")

>  
>      per_cpu_kthreads = []
>      names = list(kthreads.keys())
> @@ -688,7 +689,7 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
>              elif common[:8] == "softirq-":
>                  common = "(sirq|softirq)" + common[7:]
>                  name = "s" + name[4:]
> -            regex = common + "\/.*"
> +            regex = common + r"\/.*"
>          except:
>              idx = 0
>              regex = name
> @@ -701,9 +702,10 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
>          else:
>              mask = ",".join([hex(a) for a in \
>                       procfs.hexbitmask(kt.affinity, nr_cpus)])
> -        f.write("%s:%c:%d:%s:\[%s\]$\n" % (name, \
> +        f.write(r"%s:%c:%d:%s:\[%s\]$" % (name, \
>                             tuna_sched.sched_str(kt.policy)[6].lower(), \
>                              kt.rtprio, mask, regex))
> +        f.write("\n")

Same thing here


>      f.close()
>  
>  
> -- 

There are more files than this one that exhibit the new SyntaxWarning
in tuna, check tuna-cmd.py and all the files in the tuna dir, and please 
fix them all at once.

John Kacur

