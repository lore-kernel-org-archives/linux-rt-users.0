Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AA418EFEC
	for <linux-rt-users@vger.kernel.org>; Mon, 28 Oct 2024 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145159; cv=none; b=WNSoIU1kEhrpSiKW/DuXDKL41LSIqRr6NhygS/YKcaVBKBC5wJP+th1bIpa3h+Zr5zM8jEa2nf+rWl0/SfcSqoBwLjTlFXxhKy2QUpjDu5JYqTRGhxyZunVrdc4xblgFEG0QWOSq93VntDSlbSTxOlwZx5WAZR3+OF0WNFH4LDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145159; c=relaxed/simple;
	bh=Xak6GlCdEH2qKJBcZySvPB025ukGDmASJmZgYCNdboY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB9SP9LZhFi0S/pbUyykzH0EdIBbzfK4qvQ/RiMzH3npt/KU2Ap6bSI51F7RWXy2NpUYSt3BZqJt/dilitRE4/HWuZh8rwmdxR5amFmHc0mwevWvqplMopRfE7/NV44K7YaxKusdR2E0xGNT3THwrWkwVpHa6keuyrynaYsAomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=edbBzrH7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edbBzrH7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730145156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rqXyAMbv6p5JTKLN1i3B2DG11DqvPDMcbNYeQoV/9o=;
	b=edbBzrH7v1lcfjE422uMTwg8OpUWvR8SGHn5LypJk6DYPMHoCLLMQNjcbtzDuGebXtaRbG
	38VkNJfjM4c9bK7t2aPPuhgFrjB47A40vafuNUrPuiIF8S64NHCO40bYO/DkyFAbrMMUZf
	aoIM85yG82ahwV6ZZErHNrqvQgbGddo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-fyErDLbmOSqmKtumpZpE0A-1; Mon, 28 Oct 2024 15:52:34 -0400
X-MC-Unique: fyErDLbmOSqmKtumpZpE0A-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e290947f6f8so8423437276.2
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Oct 2024 12:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730145154; x=1730749954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rqXyAMbv6p5JTKLN1i3B2DG11DqvPDMcbNYeQoV/9o=;
        b=jxv67cc3FGUXqqVJWRfMPjw3d/NoX7Rw2rV5JTQg2i/0YhHtYA0ZeBY5g6L6zJS2A1
         FYtTwyTbzgcKO+Es3nntQpK9azmZBSUvr0xtH84YmoG1n2zEfHMzjlymhX5ERxDk7A4N
         yIULYGFF/5oM1rv5eOUl1tx8LU5wKDmz/mKWbqAaqSdQeEyfJqysUY4UvzBEg65CCAWB
         VhlMVlTuUa/ckH003nqfWUACyoasQrvtr5s+N3VplDTP5tE1mXWr6EcCgWUuIy/FHfjm
         Y+DWb14AFaMU7AQNfNyrxO5vK23AMAzF6V4PwcTrB34Xz4ygIeYIX/SnF1d6POCCou33
         /wmA==
X-Forwarded-Encrypted: i=1; AJvYcCWocGILzZFyQMOVqPjGUZ7T4Px1/Zru3mVggJ9rIPFltOmd+m9hctv14OBp04/VudAh9YxNl0t8unlSJTIBFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM0qkee+mAxcI3GxPR6no+kUswCQmF0MIceRGnoOpAhc2taI8F
	xsOr3LuV2AdlRt9WdLQhXB/lXTZUWk40o4iY6zKibfwk4VJp2HDLBzmX9XvRgj3cdC0a/sZWlO3
	irET+aClGBRHLLa60C4UmoY+sbxSgZLAKNWigZEB5LekyVLt60va/Zfa7Pm1WdOq2
X-Received: by 2002:a05:6902:1b0f:b0:e25:ca37:b669 with SMTP id 3f1490d57ef6-e3087b9653cmr6507647276.24.1730145154045;
        Mon, 28 Oct 2024 12:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxF+H/X4ly/n1l25SgQRjkchDhsnTPb2hIuY8b5I7s5tD6ybz1RFTyAfkB4+nVijURnlrrvQ==
X-Received: by 2002:a05:6902:1b0f:b0:e25:ca37:b669 with SMTP id 3f1490d57ef6-e3087b9653cmr6507639276.24.1730145153794;
        Mon, 28 Oct 2024 12:52:33 -0700 (PDT)
Received: from rhfedora ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323743besm37766121cf.78.2024.10.28.12.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 12:52:33 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:52:31 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	kernel-rts-sst <kernel-rts-sst@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] tuna: Fix string syntax warnings with raw strings
Message-ID: <Zx_rf50rNHGktRZE@rhfedora>
References: <20241025190146.149123-1-jwyatt@redhat.com>
 <9960ad89-8c0e-3588-2726-4129440fe5cb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9960ad89-8c0e-3588-2726-4129440fe5cb@redhat.com>

On Mon, Oct 28, 2024 at 11:21:18AM -0400, John Kacur wrote:
> 
> 
> On Fri, 25 Oct 2024, John B. Wyatt IV wrote:
> 
> > tuna save <filename> allows you to save your kthreads tunables to
> > a file to be used by rtctl. There were several backslashes that produce
> > an error that pylint and Python (at least 3.12) gives a `SyntaxWarning:
> > invalid escape sequence`.
> > 
> > Convert the strings written to the file with raw strings to resolve the
> > warnings.
> > 
> > Tested by comparing the diffs of the files outputted by save.
> > 
> > Signed-off-by: John B. Wyatt IV <jwyatt@redhat.com>
> > Signed-off-by: John B. Wyatt IV <sageofredondo@gmail.com>
> > ---
> >  tuna/tuna.py | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tuna/tuna.py b/tuna/tuna.py
> > index bd678e2..2dbc6cb 100755
> > --- a/tuna/tuna.py
> > +++ b/tuna/tuna.py
> > @@ -669,7 +669,8 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
> >  # The regex is matched against process names as printed by "ps -eo cmd".
> >  
> >  ''' % filename)
> > -    f.write("kthreads:*:1:*:\[.*\]$\n\n")
> > +    f.write(r"kthreads:*:1:*:\[.*\]$")
> > +    f.write("\n\n")
> 
> You can concatenate the raw string with the new lines like this, so that 
> we don't increase the number of lines
> 
> f.write(r"kthreads:*:1:*:\[.*\]$" + "\n\n")
> 

Great idea.

> >  
> >      per_cpu_kthreads = []
> >      names = list(kthreads.keys())
> > @@ -688,7 +689,7 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
> >              elif common[:8] == "softirq-":
> >                  common = "(sirq|softirq)" + common[7:]
> >                  name = "s" + name[4:]
> > -            regex = common + "\/.*"
> > +            regex = common + r"\/.*"
> >          except:
> >              idx = 0
> >              regex = name
> > @@ -701,9 +702,10 @@ def generate_rtgroups(filename, kthreads, nr_cpus):
> >          else:
> >              mask = ",".join([hex(a) for a in \
> >                       procfs.hexbitmask(kt.affinity, nr_cpus)])
> > -        f.write("%s:%c:%d:%s:\[%s\]$\n" % (name, \
> > +        f.write(r"%s:%c:%d:%s:\[%s\]$" % (name, \
> >                             tuna_sched.sched_str(kt.policy)[6].lower(), \
> >                              kt.rtprio, mask, regex))
> > +        f.write("\n")
> 
> Same thing here

ack

> 
> 
> >      f.close()
> >  
> >  
> > -- 
> 
> There are more files than this one that exhibit the new SyntaxWarning
> in tuna, check tuna-cmd.py and all the files in the tuna dir, and please 
> fix them all at once.
> 
> John Kacur
> 

I doubled checked; I could not find anymore instances of the problem.
Tested Fedora 40 with the current rpm packaged version of pylint.

Will send a v2 with the concatenated strings.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

