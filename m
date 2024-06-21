Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C021C14
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718991800; cv=none; b=hWai08IrenkK+X4T/mbdMfTVByWancOvZa8ihMjUiWt9jF8+0kUiJoFQvg31qKp5bmF5QKw3irPwSPi6d2QWG7YHgkzkKTS/80eNKkrsTZ3ezgbgqhIvx5YSOsLFS6TXNU4JSvqeFKW1EtudP4GA6N/niPI40fWN57Va8m1AwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718991800; c=relaxed/simple;
	bh=BTM0/aGAG3nQr7OfDsrcDjEl1v48RkgYJ62KcaY+/FU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pi0G8iVLAoiPoEmIWTYm9qHTwdFf/dKp8TkFmUdWN2/TeYG5X77JhTgVaE6MtmW9khEMGwNhWLhYEHaLvRNga6hB1OC3hlXstzSZhgL/h6Iv+iQ9+V7RyAdQmp8o1EEWV2Xk//T1QmaNIPbo9H6LvdUYCWQqXTjwcHIbtzmRrZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vp2ZlQ4s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vp2ZlQ4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718991797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5x369bJB5jfk95EuPxH/5rPN3Lqih0pZQhFh4DULScI=;
	b=Vp2ZlQ4s5TC9k2R/pCO1G6osgiDSgmMmXeQ7TEXRihTWgT3nVsiOrYS7iBCBpAEG5hIpyS
	6QPx7JHThy0ASFYtUx0XyhHNAEUu9yhrU3TqY6FNBFgQmH3sXaTqoubWc5si8zDzMdbMkE
	LxkKzGq7MEVxfpp60G6r4iHxmbHN4mI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-GMJnIFj8NLqNx4c8y9lE_g-1; Fri, 21 Jun 2024 13:43:16 -0400
X-MC-Unique: GMJnIFj8NLqNx4c8y9lE_g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b077178ca4so27285186d6.0
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 10:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718991796; x=1719596596;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5x369bJB5jfk95EuPxH/5rPN3Lqih0pZQhFh4DULScI=;
        b=s8RruNUmsSupsiyyYNvn7jge4S8SNJcCz60LM6JiyX+JvvFwhIFtogfdL55j3p7gc9
         tClH7C+9F6DTT19WE/OYovkisttIS/05ePK5MeTwHu03WlZoCgv67vEqUSfg7BEH6YBw
         PuHEssqaoVzjRWziKIAFbEgt9rC9HaJb0yI6Zg+TZYFU095mLXwI1JS97rezKHrFlwlm
         ysfPOwBY1P1N2NbHEwcKvyUB9bMmqsTE5AqgWhmJ/MI4cU3bZG4QVIXI0lTtZ7FQ3moB
         INKxZXyYlbUaEt9N9SM+1NGES5zj61dEIRXCRNGEq8M4trtdhCMmW3OZtTEdvd9VBw9p
         qlSw==
X-Forwarded-Encrypted: i=1; AJvYcCW7l14JfdBpeXB8fp/LNnZRr4RDsTrIfQ6FJ23xQcg1k9lBoVCeHs2SE5aJBscFQIvdrwaRbFt63lb/U+P/zKDvpqw0WY68WCF2m6KdK74=
X-Gm-Message-State: AOJu0YxtEMbvYFN6+pwes1oItTiG9CgIDTufzdkDEVO0Gwf1XaHZ3UO+
	FFGrMdqJDujc2B1stMOyLMztTcIu8rCs2DDiduUAdB9aurimmCZVNzn5IQrHbIMVdDm36+Vvu64
	k20FMFnf7hg4zdbJGd72ubFid8YJMkQv9v6NzLDJqJcJoXyB5LTwcTTjbIAQK5oiD
X-Received: by 2002:a0c:e290:0:b0:6b0:7f36:8ae1 with SMTP id 6a1803df08f44-6b501eb868emr96680656d6.52.1718991795744;
        Fri, 21 Jun 2024 10:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Co/EZO5zWnBLhtW1jWgt1KuE3NEW07Vi+G24kBl+SHkbvl7yQB38Y5tug0Wjo0E+LG0Shg==
X-Received: by 2002:a0c:e290:0:b0:6b0:7f36:8ae1 with SMTP id 6a1803df08f44-6b501eb868emr96680496d6.52.1718991795403;
        Fri, 21 Jun 2024 10:43:15 -0700 (PDT)
Received: from fionn ([76.71.123.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef96e39sm10530886d6.144.2024.06.21.10.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 10:43:14 -0700 (PDT)
Date: Fri, 21 Jun 2024 13:43:03 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Clark Williams <williams@redhat.com>, 
    linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rteval: sysstat: Convert base64 data to text before
 wrapping
In-Reply-To: <20240621021805.2086489-1-crwood@redhat.com>
Message-ID: <b5a2a144-cbd4-f2a3-dcfd-caa9e19d0812@redhat.com>
References: <20240621021805.2086489-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 20 Jun 2024, Crystal Wood wrote:

> As of Python 3, b64encode() returns data, not a string, causing this:
> 
> Traceback (most recent call last):
>   File "/home/crwood/git/rteval/./rteval-cmd", line 413, in <module>
>     ec = rteval.Measure()
>          ^^^^^^^^^^^^^^^^
>   File "/home/crwood/git/rteval/rteval/__init__.py", line 246, in Measure
>     self._report(measure_start, self.__rtevcfg.xslt_report)
>   File "/home/crwood/git/rteval/rteval/rtevalReport.py", line 63, in _report
>     self.__xmlreport.AppendXMLnodes(self._measuremods.MakeReport())
>                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/crwood/git/rteval/rteval/modules/measurement/__init__.py", line 190, in MakeReport
>     mprep_n = mp.MakeReport()
>               ^^^^^^^^^^^^^^^
>   File "/home/crwood/git/rteval/rteval/modules/measurement/__init__.py", line 62, in MakeReport
>     rep_n = RtEvalModules.MakeReport(self)
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/home/crwood/git/rteval/rteval/modules/__init__.py", line 559, in MakeReport
>     modrep_n = mod.MakeReport()
>                ^^^^^^^^^^^^^^^^
>   File "/home/crwood/git/rteval/rteval/modules/measurement/sysstat.py", line 83, in MakeReport
>     data_n = rep_n.newTextChild(None, 'data', "\n"+"\n".join(textwrap.wrap(data, 75))+"\n")
>                                                              ^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib64/python3.12/textwrap.py", line 384, in wrap
>     return w.wrap(text)
>            ^^^^^^^^^^^^
>   File "/usr/lib64/python3.12/textwrap.py", line 356, in wrap
>     chunks = self._split_chunks(text)
>              ^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib64/python3.12/textwrap.py", line 342, in _split_chunks
>     text = self._munge_whitespace(text)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib64/python3.12/textwrap.py", line 153, in _munge_whitespace
>     text = text.translate(self.unicode_whitespace_trans)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> TypeError: a bytes-like object is required, not 'dict'
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
>  rteval/modules/measurement/sysstat.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rteval/modules/measurement/sysstat.py b/rteval/modules/measurement/sysstat.py
> index 57194a2b5f45..d4646c1646f4 100644
> --- a/rteval/modules/measurement/sysstat.py
> +++ b/rteval/modules/measurement/sysstat.py
> @@ -79,7 +79,7 @@ class sysstat(rtevalModulePrototype):
>          fp = open(self.__datafile, "rb")
>          compr = bz2.BZ2Compressor(9)
>          cmpr = compr.compress(fp.read())
> -        data = base64.b64encode(cmpr + compr.flush())
> +        data = base64.b64encode(cmpr + compr.flush()).decode('utf-8')
>          data_n = rep_n.newTextChild(None, 'data', "\n"+"\n".join(textwrap.wrap(data, 75))+"\n")
>          data_n.newProp('contents', 'sysstat/sar binary data')
>          data_n.newProp('encoding', 'base64')
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

