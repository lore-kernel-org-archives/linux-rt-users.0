Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E41F426F
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Mar 2025 20:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898480; cv=none; b=ewSwh6p35tykL3fPPz6QVfw1jfYHX0ox5ZrF5gdFlzmNrJiYkWQyBRrWRjkJiMSE9EWb0MvXam3HxaG03de0JM0WeyyvDnSdZKnvrfHK3zuUYRFec5EHYMRkhNFhelQ/Vy7u5ROKNna/k1YZgjo1wrrfNsva789L6th9y5lLXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898480; c=relaxed/simple;
	bh=XlCGvZMUJqHeagTv61VMClAuUtlTS8QAgcOi5A879rQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hoWk16Cj5y3ezynVdEsdd/cqQbTn9Y6eCmyEACQTUgB8QVfaytY+tRbHxAIZlW7kVcHOQKC9K0YKaM8r8b/Ww80ps64xVwvXfRiBxQbNDGwjd5EpnSFzFN7B4HLoMmzQrWP/xBgBc3VyEQrlrb5CuoS9+GuKZNpj286E77DWHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a43RgPPP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a43RgPPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741898477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAkXCF6Il1Ks7xuuJO84b3kyeY8N1uuuDvhw7IRqayk=;
	b=a43RgPPPSX91C8AqVgE6KF2KVb3r+dFIlO7eSrAA79h0YZzq6j4qAeotSt+mviM0ST3xi/
	CiX+YIRqMg1IaTazsBQjfvn1rANZAAhMGWvf3mgoVc0gSVldtz7qF9UgzaII2WWbXTF0XS
	+UznbutUDocof6D4MRfFlUF7fJha8lw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-nq4-P3VgPzGiypmbC8qugA-1; Thu, 13 Mar 2025 16:41:13 -0400
X-MC-Unique: nq4-P3VgPzGiypmbC8qugA-1
X-Mimecast-MFC-AGG-ID: nq4-P3VgPzGiypmbC8qugA_1741898473
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e6bb677312so22348936d6.3
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Mar 2025 13:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741898473; x=1742503273;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PAkXCF6Il1Ks7xuuJO84b3kyeY8N1uuuDvhw7IRqayk=;
        b=o/CGVwxdqMpgWv9POI+cr3raJDAau2ARkKXq082A9f36pQ4Bp9c3aoRDH28ZlFSA0F
         A4htcqXiFf+NI0K22t14MiHuh3MhX4xVteQQVZwF4EISBYL5IXCbbAy16iGS9sdJFd+L
         HaWdNgl8+emXgcd2UYp9J2gkrJsJs/v7k484MxOIN4A+m7S6khkY2UJaT25WxZi2ZGKZ
         4BFSjdYX+8ab7oohuuSEyTnJcMQq3ITKGhs0Hl3qPGZElRcKt8spXVDRB/4+v5/Qo5dw
         u8z9wxgEKCqmkftgW5q3Y2HAWISqyvuTcWYNIj59xYrg1yEZ4lvJD0sCuTcwyDWAlfjb
         q1RA==
X-Forwarded-Encrypted: i=1; AJvYcCX0nXcNoyTNznpEpdE5bVDtUXzHJ+u5dikJA1z3YqKPPQxMwi6tu/nQ4XPrDkmyhGDdm4AfphjViN45f8cOkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb5HvyiAVlDBVyQyPL7v7eJBsKxO5uwJV7+vAP8Jj5hKNpzOFM
	t0gFFutkROajvRno7/ne/Szz0YqCPZtCtGASZsf5VtNwcjRniyWH6gWgFcScpmxVTi/c+Y08era
	SsDH9jtqgna4rEFP+XzYsun5JlHY5xpu98jWjIfvdQIquI0cKedUSs+YSrkojycjQ
X-Gm-Gg: ASbGncv/Y00fXkjbYi03OHAxo25jphPDgZjMoTY2QVFe0WuYwrFgMP7iHw94dB86EQo
	BOotYXW4g+qNNwtara00TIIqBioSnnzbUeYHMIjwlJcPHfXCYFilSxzzH4LmdQzRc62p4uT6xzj
	NfG0ziDJmF3YJwwaB7eHHIScgaGq1g+ReNOEPyRR7keh4CSz+wdJDLpGs9s0ltd23k3/Y/QJCOh
	TzyFLxr4D0LC1QphmTfSMh1gCv/JvKQpNjE1h9LYwyDzdAe/eU+zfwgMT2GuDGhe53CqFY+MVRW
	UDuzxfN3aKuEmhHXutwA6XY9jIrcICsmrXqFvqg0IBtpyGQ=
X-Received: by 2002:ad4:5bee:0:b0:6e8:f33f:147e with SMTP id 6a1803df08f44-6eae79a2447mr19801646d6.6.1741898473284;
        Thu, 13 Mar 2025 13:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0EN7EOggFWSneZvEBIc6FzbUIIxgu9hPFjCK1wXFFBvSJ6fb5HU4CjzmwRRURNfVOLUpx0Q==
X-Received: by 2002:ad4:5bee:0:b0:6e8:f33f:147e with SMTP id 6a1803df08f44-6eae79a2447mr19801346d6.6.1741898472948;
        Thu, 13 Mar 2025 13:41:12 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24dda0sm13734046d6.58.2025.03.13.13.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:41:12 -0700 (PDT)
Message-ID: <cb55cb771373e22a8a1f64c11bebbc42a8ac4034.camel@redhat.com>
Subject: Re: [PATCH v4 2/2] tuna: Add idle_state control functionality
From: Crystal Wood <crwood@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, "John B. Wyatt IV"
	 <jwyatt@redhat.com>
Cc: Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>, 
 linux-rt-users@vger.kernel.org, kernel-rts-sst <kernel-rts-sst@redhat.com>,
  "John B. Wyatt IV" <sageofredondo@gmail.com>
Date: Thu, 13 Mar 2025 15:41:11 -0500
In-Reply-To: <erlhf5eul3ozro2maafv5josmrhd7xjzx7gue5ndjriabbmzgh@wcquadlmss5x>
References: <20250311203034.8065-1-jwyatt@redhat.com>
	 <20250311203034.8065-3-jwyatt@redhat.com>
	 <erlhf5eul3ozro2maafv5josmrhd7xjzx7gue5ndjriabbmzgh@wcquadlmss5x>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-12 at 11:41 -0300, Wander Lairson Costa wrote:
> On Tue, Mar 11, 2025 at 04:30:19PM -0400, John B. Wyatt IV wrote:
> > Allows Tuna to control cpu idle-state functionality on the system,
> > including querying, enabling, disabling of cpu idle-states to control
> > power usage or to test functionality.
> >=20
> > This requires cpupower, a utility in the Linux kernel repository and
> > the cpupower Python bindings added in Linux 6.12 to control cpu
> > idle-states.
> >=20
> > This patch revision includes text snippet suggestions by Crystal Wood
> > (v2) and small Python suggestions by John Kacur (v3 and v4).
> >=20
> > Suggested-by: Crystal Wood <crwood@redhat.com>

Eh, this tag makes it look like I suggested the overall idea, not that I
gave feedback on the patch...

> > @@ -115,8 +116,12 @@ def gen_parser():
> >              "disable_perf": dict(action=3D'store_true', help=3D"Explic=
itly disable usage of perf in GUI for process view"),
> >              "refresh": dict(default=3D2500, metavar=3D'MSEC', type=3Di=
nt, help=3D"Refresh the GUI every MSEC milliseconds"),
> >              "priority": dict(default=3D(None, None), metavar=3D"POLICY=
:RTPRIO", type=3Dtuna.get_policy_and_rtprio, help=3D"Set thread scheduler t=
unables: POLICY and RTPRIO"),
> > -            "background": dict(action=3D'store_true', help=3D"Run comm=
and as background task")
> > -         }
> > +            "background": dict(action=3D'store_true', help=3D"Run comm=
and as background task"),
> > +            "idle_info": dict(dest=3D'idle_info', action=3D'store_cons=
t', const=3DTrue, help=3D'Print general idle information for the selected C=
PUs, including index values for IDLE-STATE.'),
> > +            "idle_state_disabled_status": dict(dest=3D'idle_state_disa=
bled_status', metavar=3D'IDLE-STATE', type=3Dint, help=3D'Print whether IDL=
E-STATE is enabled on the selected	CPUs.'),

You have a tab between "selected" and "CPUs".

> > +            "disable_idle_state": dict(dest=3D'disable_idle_state', me=
tavar=3D'IDLE-STATE', type=3Dint, help=3D'Disable IDLE-STATE on the selecte=
d CPUs.'),
> > +            "enable_idle_state": dict(dest=3D'enable_idle_state', meta=
var=3D'IDLE-STATE', type=3Dint, help=3D'Enable IDLE-STATE on the selected C=
PUs.')
> > +    }
> > =20
> >      parser =3D HelpMessageParser(description=3D"tuna - Application Tun=
ing Program")
> > =20
> > @@ -127,6 +132,9 @@ def gen_parser():
> > =20
> >      subparser =3D parser.add_subparsers(dest=3D'command')
> > =20
> > +    idle_set =3D subparser.add_parser('idle_set',
> > +                                    description=3D'Manage CPU idle sta=
te disabling (requires libcpupower and it\'s Python bindings)',
> > +                                    help=3D'Set all idle states on a g=
iven CPU-LIST.')

s/Set all idle states/Manage idle states/

I still don't like the "idle_set" name.  This does more than setting,
unlike the standalone utility that we're apparently reimplementing.

> > diff --git a/tuna/cpupower.py b/tuna/cpupower.py
> > new file mode 100755
> > index 0000000..7913027
> > --- /dev/null
> > +++ b/tuna/cpupower.py
> > @@ -0,0 +1,184 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +# Copyright (C) 2024 John B. Wyatt IV
> > +
> > +from typing import List
> > +import tuna.utils as utils
> > +
> > +cpupower_required_kernel =3D "6.12"
> > +have_cpupower =3D None
> > +
> > +try:
> > +    import raw_pylibcpupower as lcpw
> > +    lcpw.cpufreq_get_available_frequencies(0)
> > +    have_cpupower =3D True
> > +except:
>=20
> Catch all statements in Python are bad IMO, because they catch syntax
> errors as well. We should at least print the exception.

The (expected) exception is for the case where the package is not
installed and thus we disable that feature.  We don't want to print
anything in that case (unless the user tries to use these features).=20
But yeah, being more specific in the catch makes sense.

> > +        def __init__(self, cpu_list=3DNone):
> > +            if cpu_list =3D=3D None or cpu_list =3D=3D []: # args.cpu_=
list =3D=3D [] when the -c option is not used
>=20
> Nit: use the "is" operator to compare against None.

Or just use "if cpu_list:" like the existing code does.

That's also pretty obnoxious behavior of the code that sets
args.cpu_list...

> > +        @staticmethod
> > +        def print_idle_info(cpu_list=3D[0]):

This default is never used.  cpu_list is only ever set to
self.__cpu_list.  Why is this a static method?

> > +            for cpu in cpu_list:
> > +                idle_info =3D Cpupower.get_idle_info(cpu)
> > +                print_str =3D f"""
> > +CPUidle driver: {idle_info["CPUidle-driver"]}
> > +CPUidle governor: {idle_info["CPUidle-governor"]}
> > +analyzing CPU {cpu}
> > +
> > +Number of idle states: {idle_info["idle-states-count"]}
> > +Available idle states: {idle_info["available-idle-states"]}
> > +"""
> > +                for state in idle_info["cpu-states"]:
> > +                    print_str +=3D f"""{state["Idle State Name"]}
> > +Flags/Description: {state["Flags/Description"]}
> > +Latency: {state["Latency"]}
> > +Usage: {state["Usage"]}
> > +Duration: {state["Duration"]}
> > +"""
> > +                print(
> > +                    print_str
> > +                )
>=20
> nit: I don't think we need three lines for this statement.

Why not just print each state inside the loop, instead of building one
big string?

> > +            elif args.enable_idle_state !=3D None:
>=20
> nit: Use the "is" operator to compare against None.
>=20
> > +                cstate_index =3D args.enable_idle_state
> > +                cstate_list, cstate_amt =3D self.get_idle_states(self.=
__cpu_list[0]) # Assuming all cpus have the same idle state
> > +                if cstate_index < 0 or cstate_index >=3D cstate_amt:
> > +                    print(f"Invalid idle state range. Total for this c=
pu is {cstate_amt}")
>=20
> nit: Use the "is" operator to compare against None.
>=20
> > +                    return 1
> > +                cstate_name =3D cstate_list[cstate_index]
> > +                ret =3D self.disable_idle_state(cstate_index, 0)
> > +                for e in ret:
> > +                    self.handle_common_lcpw_errors(e, self.LCPW_ERROR_=
THREE_CASE, cstate_name)

Why isn't self.disable_idle_state() doing the error handling (which is
still duplicated between enable and disable)?  And as I mentioned
before, isn't libcpupower itself doing the same range checking?

It looks like the get_idle_states() call is just for that redundant
check, and to print the name in an error...  You could wait until you
actually get an error, and then just call lcpw.cpuidle_state_name on
the particular cpu and state id.  That would get rid of the assumption
about all cpus having the same idle states, and be simpler.

-Crystal

