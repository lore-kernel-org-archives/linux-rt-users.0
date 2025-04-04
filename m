Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B113B2BB
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Apr 2025 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743799017; cv=none; b=SPzQ3CwjecRpzEQYfeOO2DxxBXJIlrNH+fCkYnfpYhPwxdbkqVUrByvwFZY14LzmgcHVZaa5QZ2l6X0ckaiU9styzkkmVvfpccOf3T1C5v6XxXL1Z5ghVSIiIRZA1e9Bn255eQ3JYpwn/UFmFdMN1r76/PkSckzdIqmbKcyGQEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743799017; c=relaxed/simple;
	bh=9wcfkptunozLUhiG89tucbkPFAQtQD6ZbA25O3yyfSI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A7Z5jPs3VOsGUtSxTTnmtp24SxQesByRW/Z/OcsfVVnvonDS8D0EbhfFjwxZHhnFxLLbibTfCQeiIshF6MnXe53GNk4X1CgpwnA3eswUJtcATSorKYXpzhm+MnOE2z+rVe3uHncEDcJkbj05oeFdraEvoXq5MhdhC+LDXqwjLso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COB6WvSv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COB6WvSv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743799013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=si3TRUQId2q8aOqN1Rlq836NM1VG9xfOiYDqR8+Zcjk=;
	b=COB6WvSvZ/jJcQ1aQ98NmIa1YiB6VVIpQXFIyfO2rw6G5QmGCSLdrqn6O+AlOs2nI3XhpU
	uHxqN4qaomvDjMhK/RrXl7K/ADHhIDnahCS5sMCD0HLKt9Qutu6YImSQEj17ql/L97iv7E
	KTs1PUKyZKW3uU26f4GZnxGaJiJZDLA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-JSihImCsOwWEipTFl5dQ4Q-1; Fri, 04 Apr 2025 16:36:52 -0400
X-MC-Unique: JSihImCsOwWEipTFl5dQ4Q-1
X-Mimecast-MFC-AGG-ID: JSihImCsOwWEipTFl5dQ4Q_1743799012
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4769273691dso43947481cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Apr 2025 13:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743799012; x=1744403812;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=si3TRUQId2q8aOqN1Rlq836NM1VG9xfOiYDqR8+Zcjk=;
        b=PW7zuA35xc5xp6U/CvH4ULx5QqJac1L4ZqBYosivuHEl1IBotyWOv35gZMp6sFNa0v
         e4ZWB21DwU27qZcaoba6KaeZ4ADpDPOnJtAqMF9smXiDCpKaRCaJqz+lCiwF8dPDGdgt
         Fny2EswRCW0s3iOdDNtEMEfkrnDnYOSVdSlN02IXJNehuIis5YNjlYcrfSVN8BV+6nbh
         hx18tqwGZsLaF99HtI+9gEOgmIgKLJWlBj1NyOYWoluqdk6ITPh2DvvhHM7bT8WbSKJ3
         voMVnIvmQvppd6YwS5gjiTRV8KqsVfv2Y+m6hV/qPQNyGWioUTdfwvvFZ12a20UkrXd5
         1fFw==
X-Forwarded-Encrypted: i=1; AJvYcCXLRz5f107qyoN4BMcjvPn37swnO+97+m88g5UxA5xJX7hhDdDE3uwzjXuBHQjUKJ4012Hlrx4sczDxIGsfRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfZMMbqOCFHt1kXJVb4RpW08F6bB+zecWaQmpVxVOO4j/etyL
	DFRBVEcy4AiFy7uGPq4s8Ng5CMAaSTbHq5KqBqJ8gwKpmvkWybY1rre5i3SX7tus++Wi9Yj6BtB
	3YRn3RCBhaHeUfzRimrk7v7jQDQvWCXXVFtBcmz4GfXP2eJv14/ln7fTn/zMH0IOOdPB0oyn2
X-Gm-Gg: ASbGncvqnQki+5gqdQbyu0J7rerOBI3clZB1J6fHGEXUToFuMJmZjQFMH0/AH/QzcEk
	9mb1BlbLxEbgDP9DEFFy2K33UfZari3hgP9P7jJ8Kf+PqusYQHD9D9ZKouJeOGQQeBuqsCbsy6H
	X/N+fZKQMTx31EGeyb6nXqmU9IYVfDt1Qfe+TM5PH52AG0wXvFowcktxCEeVtEBauWDaataQUs4
	bWCn4ThXCHHXmxa7dq2aQt9uDOziVaEyWTGY8/IXrkK9D05YDcMgMBMyj9DSfXRdCJ8Y0FqmUDV
	pp5IcA==
X-Received: by 2002:a05:622a:1647:b0:476:6215:eaf6 with SMTP id d75a77b69052e-4792598e95cmr71706191cf.31.1743799011667;
        Fri, 04 Apr 2025 13:36:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOrKPCzbU8Eg1hqLLA7rixRBfe9HKQPKet6JUCuqGdEzW8sG/fpkQJJE4cE9b47JhRnLdo/Q==
X-Received: by 2002:a05:622a:1647:b0:476:6215:eaf6 with SMTP id d75a77b69052e-4792598e95cmr71705871cf.31.1743799011340;
        Fri, 04 Apr 2025 13:36:51 -0700 (PDT)
Received: from fionn ([142.189.102.216])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b15eda8sm26640971cf.81.2025.04.04.13.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 13:36:50 -0700 (PDT)
Date: Fri, 4 Apr 2025 16:36:49 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: Wander Lairson Costa <wander@redhat.com>, 
    "John B. Wyatt IV" <jwyatt@redhat.com>, 
    Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v4 2/2] tuna: Add idle_state control functionality
In-Reply-To: <cb55cb771373e22a8a1f64c11bebbc42a8ac4034.camel@redhat.com>
Message-ID: <85674b73-2f87-7203-6384-664393da7133@redhat.com>
References: <20250311203034.8065-1-jwyatt@redhat.com> <20250311203034.8065-3-jwyatt@redhat.com> <erlhf5eul3ozro2maafv5josmrhd7xjzx7gue5ndjriabbmzgh@wcquadlmss5x> <cb55cb771373e22a8a1f64c11bebbc42a8ac4034.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 13 Mar 2025, Crystal Wood wrote:

> On Wed, 2025-03-12 at 11:41 -0300, Wander Lairson Costa wrote:
> > On Tue, Mar 11, 2025 at 04:30:19PM -0400, John B. Wyatt IV wrote:
> > > Allows Tuna to control cpu idle-state functionality on the system,
> > > including querying, enabling, disabling of cpu idle-states to control
> > > power usage or to test functionality.
> > > 
> > > This requires cpupower, a utility in the Linux kernel repository and
> > > the cpupower Python bindings added in Linux 6.12 to control cpu
> > > idle-states.
> > > 
> > > This patch revision includes text snippet suggestions by Crystal Wood
> > > (v2) and small Python suggestions by John Kacur (v3 and v4).
> > > 
> > > Suggested-by: Crystal Wood <crwood@redhat.com>
 
> Eh, this tag makes it look like I suggested the overall idea, not that I
> gave feedback on the patch...

Good point, I can remove it.

> 
> > > @@ -115,8 +116,12 @@ def gen_parser():
> > >              "disable_perf": dict(action='store_true', help="Explicitly disable usage of perf in GUI for process view"),
> > >              "refresh": dict(default=2500, metavar='MSEC', type=int, help="Refresh the GUI every MSEC milliseconds"),
> > >              "priority": dict(default=(None, None), metavar="POLICY:RTPRIO", type=tuna.get_policy_and_rtprio, help="Set thread scheduler tunables: POLICY and RTPRIO"),
> > > -            "background": dict(action='store_true', help="Run command as background task")
> > > -         }
> > > +            "background": dict(action='store_true', help="Run command as background task"),
> > > +            "idle_info": dict(dest='idle_info', action='store_const', const=True, help='Print general idle information for the selected CPUs, including index values for IDLE-STATE.'),
> > > +            "idle_state_disabled_status": dict(dest='idle_state_disabled_status', metavar='IDLE-STATE', type=int, help='Print whether IDLE-STATE is enabled on the selected	CPUs.'),
> 
> You have a tab between "selected" and "CPUs".

Nice catch, thanks

> 
> > > +            "disable_idle_state": dict(dest='disable_idle_state', metavar='IDLE-STATE', type=int, help='Disable IDLE-STATE on the selected CPUs.'),
> > > +            "enable_idle_state": dict(dest='enable_idle_state', metavar='IDLE-STATE', type=int, help='Enable IDLE-STATE on the selected CPUs.')
> > > +    }
> > >  
> > >      parser = HelpMessageParser(description="tuna - Application Tuning Program")
> > >  
> > > @@ -127,6 +132,9 @@ def gen_parser():
> > >  
> > >      subparser = parser.add_subparsers(dest='command')
> > >  
> > > +    idle_set = subparser.add_parser('idle_set',
> > > +                                    description='Manage CPU idle state disabling (requires libcpupower and it\'s Python bindings)',
> > > +                                    help='Set all idle states on a given CPU-LIST.')
> 
> s/Set all idle states/Manage idle states/
> 
> I still don't like the "idle_set" name.  This does more than setting,
> unlike the standalone utility that we're apparently reimplementing.

I agree that idle_set is not the ideal name since if you look at the 
cpupower tool, this is just one function, maybe cpupower would be a better 
name. It's a bit unfair to say we're reimplementing the tool. The 
functionality is in upstream kernel code and John Wyatt created python 
bindings for that, and that is what he is using here. I think it is better 
to have all the tools for manipulating the environment through one tool
and not make the user go search for multiple tools to get the job done.

> 
> > > diff --git a/tuna/cpupower.py b/tuna/cpupower.py
> > > new file mode 100755
> > > index 0000000..7913027
> > > --- /dev/null
> > > +++ b/tuna/cpupower.py
> > > @@ -0,0 +1,184 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +# Copyright (C) 2024 John B. Wyatt IV
> > > +
> > > +from typing import List
> > > +import tuna.utils as utils
> > > +
> > > +cpupower_required_kernel = "6.12"
> > > +have_cpupower = None
> > > +
> > > +try:
> > > +    import raw_pylibcpupower as lcpw
> > > +    lcpw.cpufreq_get_available_frequencies(0)
> > > +    have_cpupower = True
> > > +except:
> > 
> > Catch all statements in Python are bad IMO, because they catch syntax
> > errors as well. We should at least print the exception.

Yes, that could be improved
> 
> The (expected) exception is for the case where the package is not
> installed and thus we disable that feature.  We don't want to print
> anything in that case (unless the user tries to use these features). 
> But yeah, being more specific in the catch makes sense.
> 
> > > +        def __init__(self, cpu_list=None):
> > > +            if cpu_list == None or cpu_list == []: # args.cpu_list == [] when the -c option is not used
> > 
> > Nit: use the "is" operator to compare against None.

These nits from a previous message are valid, but of course not critical, 
they can be fixed in subsequent patches.
> 
> Or just use "if cpu_list:" like the existing code does.
> 
> That's also pretty obnoxious behavior of the code that sets
> args.cpu_list...
> 
> > > +        @staticmethod
> > > +        def print_idle_info(cpu_list=[0]):
> 
> This default is never used.  cpu_list is only ever set to
> self.__cpu_list.  Why is this a static method?

This is a different cpu_list than the instantiated one.
This is which cpus the user wants the info from. I think
the name is confusing here. 

> 
> > > +            for cpu in cpu_list:
> > > +                idle_info = Cpupower.get_idle_info(cpu)
> > > +                print_str = f"""
> > > +CPUidle driver: {idle_info["CPUidle-driver"]}
> > > +CPUidle governor: {idle_info["CPUidle-governor"]}
> > > +analyzing CPU {cpu}
> > > +
> > > +Number of idle states: {idle_info["idle-states-count"]}
> > > +Available idle states: {idle_info["available-idle-states"]}
> > > +"""
> > > +                for state in idle_info["cpu-states"]:
> > > +                    print_str += f"""{state["Idle State Name"]}
> > > +Flags/Description: {state["Flags/Description"]}
> > > +Latency: {state["Latency"]}
> > > +Usage: {state["Usage"]}
> > > +Duration: {state["Duration"]}
> > > +"""
> > > +                print(
> > > +                    print_str
> > > +                )
> > 
> > nit: I don't think we need three lines for this statement.
> 
> Why not just print each state inside the loop, instead of building one
> big string?

valid, but I think John Wyatt was thinking the string could be 
useful for other purposes.
> 
> > > +            elif args.enable_idle_state != None:
> > 
> > nit: Use the "is" operator to compare against None.
> > 
> > > +                cstate_index = args.enable_idle_state
> > > +                cstate_list, cstate_amt = self.get_idle_states(self.__cpu_list[0]) # Assuming all cpus have the same idle state
> > > +                if cstate_index < 0 or cstate_index >= cstate_amt:
> > > +                    print(f"Invalid idle state range. Total for this cpu is {cstate_amt}")
> > 
> > nit: Use the "is" operator to compare against None.
> > 
> > > +                    return 1
> > > +                cstate_name = cstate_list[cstate_index]
> > > +                ret = self.disable_idle_state(cstate_index, 0)
> > > +                for e in ret:
> > > +                    self.handle_common_lcpw_errors(e, self.LCPW_ERROR_THREE_CASE, cstate_name)
> 
> Why isn't self.disable_idle_state() doing the error handling (which is
> still duplicated between enable and disable)?  And as I mentioned
> before, isn't libcpupower itself doing the same range checking?
> 
> It looks like the get_idle_states() call is just for that redundant
> check, and to print the name in an error...  You could wait until you
> actually get an error, and then just call lcpw.cpuidle_state_name on
> the particular cpu and state id.  That would get rid of the assumption
> about all cpus having the same idle states, and be simpler.
> 
> -Crystal
> 

The code is functioning, it can be improved, let's fix a few more
problems and let it in, and then it can be improved incrementally after 
that.

John Kacur 

