Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283AE1991DF
	for <linux-rt-users@vger.kernel.org>; Wed, 30 Oct 2024 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730325844; cv=none; b=aDSTx/iELFZmzV5hbqKWz9cjP6wX7YHqc5Vg/nhadmYZlEsgutkGlMpxp0iCVMCUCpMZNg9fIuhqMezlV/bpHs948esUYO+UA2UVEKdf2Yd3eRd47NMEzgNgFIbmip4qSRWqEmit7DmBqk7yU/DSwz8GMRnkazIU/hHHeb820fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730325844; c=relaxed/simple;
	bh=YaweDUHa06adOUA/TBvhi/0yZGGxGKIQcS9N2aFNIcY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ONPP+7a1ieD+ZTegPUa4KneSHy3f6UQEkHUL0FiqEM/Y++W9gU3I1fC9CSJqp5nfpaZsuwxPloE5t0rqrHdXHp7/FrOISMT+I+RCINuNQcuWYHvppf13Za8AO1cpHm3+2q+/Aus/MAVFztJmRiHI6x/zax+G5CQp4opsXHjDJfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJEkPe0m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJEkPe0m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730325841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vfIyF+fck7D0NO7CU6/kxsN1GNRTWfA8Xxa4DmGdEFg=;
	b=jJEkPe0mnUZK4WfcBiGtdKBRduIUZAyd6cNoJwdMdxKUNDt/Rn6y0AsXiS51YZdK/QMnfy
	MxM42AF58avSsJ2kzFeHjWxUjYRJ30B7oaZlwZxVufJ37OGpLTtobFdn57n+MlTcUcnopP
	aKeKx8zV7+HG6EQVtRgLUnNvVJRiofc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-NbBaPknAOEikWcZYChdcjA-1; Wed, 30 Oct 2024 18:03:59 -0400
X-MC-Unique: NbBaPknAOEikWcZYChdcjA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46089122a64so6510791cf.0
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Oct 2024 15:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730325839; x=1730930639;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfIyF+fck7D0NO7CU6/kxsN1GNRTWfA8Xxa4DmGdEFg=;
        b=wbylPJHcuhRegvNMAmfgWld2A/OkxcD5omV1aHYEBzMIoMd8iiz2YnrVzE+8zm79D4
         KFQYJR+Wz5ZAbAQ87K48UiYjpXr9Sx4A62furSrdPdk4rU6hw812p3qqp8wFq7aOxfzQ
         1sOTiEcQTsY9CBBgw0E9zbDSQb79zZpshigDFNE1OhNjWZKMCM1osUGI5ulnig/UJbbS
         dgUppl99JH9vvT1yHMiclXePdAHQzrlrCqMQ/wXCVAwj1EouAg2iXUqiocRRwiGO3tF1
         JJFDqJeO8eFLqIsEKxoP9iQN4Eu9/Ti8TJcoG4jPE2OoUEs78AozjVfHItaz8ssFQ25+
         E8EA==
X-Forwarded-Encrypted: i=1; AJvYcCWHDQAe9+9Bxm1ynfRDr5cZxjTMkPb2eVgZ3o7Q9B+hgWSYeYMWCjVpQI5xYZQJh44qHQcJ+sovHzdWgUck9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN7RCsmXlv+MfATNhWkHjNUDS5bJdVP2R2MM+l8VYfYDqMNWgk
	wDgSI3lY57qqZ0YwopEsEG6/zkjVeh0wIqQI6gatyQt+NYtXUqPSgatt7Y46lTDbh9OlcBxbRyL
	7Wck/Lr5tvYeX08EoMQ4x2+/Qa8PJZidICFyRk4mkDmPEfG9D22rC0y7+0NHIjPiaKwsPlHc7
X-Received: by 2002:ac8:5901:0:b0:461:59:23cc with SMTP id d75a77b69052e-461716ffe70mr60387301cf.25.1730325838924;
        Wed, 30 Oct 2024 15:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoZTMVJnm4PfNXG6m2DMsr9Y1FZ/KU9f9n4byTYc4tMEWwiA0704R1sbPnGw1SoIvukvd2JQ==
X-Received: by 2002:ac8:5901:0:b0:461:59:23cc with SMTP id d75a77b69052e-461716ffe70mr60387091cf.25.1730325838523;
        Wed, 30 Oct 2024 15:03:58 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad1a12b4sm740851cf.82.2024.10.30.15.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 15:03:58 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:03:55 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
cc: "John B. Wyatt IV" <jwyatt@redhat.com>, 
    Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH] pi_stress: Add memory barrier to resolve crash
In-Reply-To: <q4i6uhr7kg2gj4u5ghwkvemvvy73mggu7myirjm4uwndpra2mi@yicsw5d6p5tf>
Message-ID: <6f4dd034-0a11-5792-487b-670719a6fc01@redhat.com>
References: <20241024162620.349934-1-jwyatt@redhat.com> <q4i6uhr7kg2gj4u5ghwkvemvvy73mggu7myirjm4uwndpra2mi@yicsw5d6p5tf>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 29 Oct 2024, Wander Lairson Costa wrote:

> On Thu, Oct 24, 2024 at 12:26:14PM -0400, John B. Wyatt IV wrote:
> > This patch is also an error report seen on RHEL 9 and Fedora 40.
> > pi_stress crashes if you run this near full cores with one core
> > (2 threads) free for housekeeping. The crash usually happens at
> > around 2 hours of pi_stress running. This issue was reproduced
> > on a RHEL server with 2 sockets of 10 cores/20 threads (total 40
> > threads) and a Fedora server with 2 sockets of 56 cores/112
> > threads (total 226 threads).
> > 
> > The pthread_barrier_wait should guarantee that only one
> > thread at a time interacts with the variables below that
> > if block.
> > 
> > GCC -O2 optimization rearranges the two increments above the wait
> > function calls. This causes a race issue found by Helgrind.
> > You can prove this by commenting out the memory barrier
> > and compiling with `-O0`. The crash does not happen with -O0.
> > Thank you to Valentin Schneider <vschneid@redhat.com> for
> > suggesting about -O2.
> > 
> > Add a memory barrier to force GCC to increment the variables
> > below the pthread calls. The memory barrier prevented any crashes
> > for several 24 hours tests. This function depends on C11.
> > 
> > Reported-by: Valgrind's Helgrind tool
> > 
> > Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
> > Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
> > ---
> >  src/pi_tests/pi_stress.c | 22 +++++++++++++++++++++-
> >  1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> > index 371e906..37023a1 100644
> > --- a/src/pi_tests/pi_stress.c
> > +++ b/src/pi_tests/pi_stress.c
> > @@ -44,6 +44,7 @@
> >  #include <stdint.h>
> >  #include <inttypes.h>
> >  #include <limits.h>
> > +#include <stdatomic.h>
> >  
> >  #include "rt-sched.h"
> >  #include "rt-utils.h"
> > @@ -952,12 +953,31 @@ void *high_priority(void *arg)
> >  			    ("high_priority[%d]: pthread_barrier_wait(finish): %x", p->id, status);
> >  			return NULL;
> >  		}
> > +
> > +
> > +		/**
> > +		 * The pthread_barrier_wait should guarantee that only one
> > +		 * thread at a time interacts with the variables below that
> > +		 * if block.
> > +		 *
> > +		 * GCC -O2 rearranges the two increments above the wait
> > +		 * function calls causing a race issue if you run this
> > +		 * near full cores with one core (2 threads) free for
> > +		 * housekeeping. This causes a crash at around 2 hour of
> > +		 * running. You can prove this by commenting out the barrier
> > +		 * and compiling with `-O0`. The crash does not show with
> > +		 * -O0.
> > +		 *
> > +		 * Add a memory barrier to force GCC to increment the variables
> > +		 * below the pthread calls. This funcion depends on C11.
> > +		 **/
> 
> I agree with Crystal. AFAIU, the compiler should not reorder before
> pthread_barrier_wait(). Something odd is going on here. However, I am
> not familiar with the code base. What's the repo for this?

This is one of the programs in the rt-tests suite

Clone one of the following
git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
https://kernel.googlesource.com/pub/scm/utils/rt-tests/rt-tests.git


> 
> Btw, did you look at the generated assembly code?
> 
> > +		atomic_thread_fence(memory_order_seq_cst);
> > +
> 
> If the problem is program order, a simple compiler barrier with acquire
> semantics should work:
> 
>         atomic_signal_fence(memory_order_acquire);
> 
> >  		/* update the group stats */
> >  		p->total++;
> >  
> >  		/* update the watchdog counter */
> >  		p->watchdog++;
> > -
> >  	}
> >  	set_shutdown_flag();
> >  
> > -- 
> > 2.47.0
> > 
> 
> 
> 

