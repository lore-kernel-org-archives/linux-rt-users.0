Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9018101FF
	for <linux-rt-users@vger.kernel.org>; Fri,  4 Apr 2025 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743807032; cv=none; b=ZlH1qu40w2QqnwCYISQuG9Uhbh5vGJ2UNR6rVk2D43Asxzhj5pciQZbLJpf7LYk2SGnJmA26wCflfJONqIjAwLYvbeCK0HsPWiR9SV0QO4Exu+ade3lqZ9zFuz5mXBF9t1oQWQ+3VNdQ+e1t64OpwSbW47MKUHxLVViMJqTmPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743807032; c=relaxed/simple;
	bh=tRhkZKJAd1GoD2lBLEb82TCiZLfOffQb+WZz2luY/uc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QZMBzN5zxZWAgvLHY2LLAIoUviFD7hZiiNJPfgNinqwWkwzw1fw6RCR/pKas8Mz7uNk+DDVujbjsUAzPiSr06Kq+EzY/PDJFgMhtKaro0z3SQlg+AyomQkCEYGjpKNPdr4XGhA/yBmHBFkIGj5cTaxQ4P/AgQqPXdPUx1FzbkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IVQZWwMJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVQZWwMJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743807029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q8PTl8gFblsVFZCEBxkJ5nU7tkGqv6kYHstQru15Uwg=;
	b=IVQZWwMJXXsqHGSv4UBNHOtLvf0rvxfJPD8XN5hyp5y4m410vwiQ1zjC6d3E5jE0TgnUAh
	hPup5blyOS7sBbh2agrQKwv4d3frsTUPlk1CWMxePmTZYUdOP5zaWhspvQEeiChxtLYf5p
	iK/bU/kAWsoFdee5T6feXLE4yz4pK9Q=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-8tCwCmuFNxqIVcl4CtCHUA-1; Fri, 04 Apr 2025 18:50:28 -0400
X-MC-Unique: 8tCwCmuFNxqIVcl4CtCHUA-1
X-Mimecast-MFC-AGG-ID: 8tCwCmuFNxqIVcl4CtCHUA_1743807027
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d451ad5b2dso38487435ab.0
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Apr 2025 15:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743807027; x=1744411827;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q8PTl8gFblsVFZCEBxkJ5nU7tkGqv6kYHstQru15Uwg=;
        b=FARIe7zRvDGsmhKIqaL899Y1KrZro0KcueA0sVAfwvHOJS7k6glTaC1B5jQwjux5Qm
         8YWiyn58Tro6wtRlq5wm3sTtATz/+HghvQt4CnnS4tVHsH+j9hqOxbuCjJtYlvLlN8SU
         KI2cVwLTcwubL37efp6YkIgfo9J4EoLh5CReOblLkttMWr/XQ0fnoXqXhWB+jhM+SxWC
         BR/6wC6mFsqkx759eG7T35S7W0BxnxUnYBcwEX09TEPlhG1hNyTCg8yCGKzm3/prsWBh
         IROzOQMppva+NsMNMrxr7nYpUtOw3BbH/3RG5lnZMC+o1UcumXOst+WT9ZfAhPD4+76K
         Hpuw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8Jue3A3C8Jvy9DXhZ05TGSYY/2+43mV+IpFz+A7raHz3K7iPYQiG2aLEhBVtbymwNiKccB428V7UFTFEkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4v+EojhoMBFgjwxO0NAxpXcFag7eoXzmCk0BHZQ1xgYYiwUU
	C6VWmhse59htygRP4eMXtGD64SJQHh8nQnx/6pnkeVCuxwCSVTeKpYIgWc/UqQnxZ+9ZYQK05Bw
	SmxJjuoMJAdRJ8+gHtxVflZDUxi3ZVXmCP9ilGKCXZKHeyMguiJlA5w0Gzt+omyNJ
X-Gm-Gg: ASbGnctgamXDSlLW+IHzxcyXFt9cNy7qqyvmVVsKz78jtUOddusmUMsdyDG6FI9KtLM
	eADEl2pyCPYziGMRFmvPSkYnHwSVYix+xFVvtKTplVxTHaPQRHTu7ybKHFcccmS4Cd5J38JJCIK
	UhT+gaNl3GQuiqzz8q5VlgLnfnJ2K/t1j1pHJx6ZfX0njCCEjU3dq4fIbnduegQNMVYZ9ztH49j
	CwjG6qXj3yIn7jXDr8uCEkWNm9trRKrHfxA8X5/RPGsCw4BCY3d7l1xq3Rf9oIjh9wxBvfie6bo
	BdbOeeEfaA/tl72xmcJ8Sj7Jpy5iIelbPEpSCNLYd7ze
X-Received: by 2002:a05:6e02:4406:10b0:3d3:de5f:af25 with SMTP id e9e14a558f8ab-3d6dca86dfemr76387425ab.0.1743807027321;
        Fri, 04 Apr 2025 15:50:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/go9y41i2TrqOzcA0mRveb6D14PBc+AVTiVF3ek5ivrHzDaHhTiW0X0Jttl/visYEyu+Cxw==
X-Received: by 2002:a05:6e02:4406:10b0:3d3:de5f:af25 with SMTP id e9e14a558f8ab-3d6dca86dfemr76387305ab.0.1743807027005;
        Fri, 04 Apr 2025 15:50:27 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f4b5d40520sm1040229173.111.2025.04.04.15.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 15:50:26 -0700 (PDT)
Message-ID: <443670473eaf9e9aff5a9314dec21b728eaf4599.camel@redhat.com>
Subject: Re: [PATCH v4 2/2] tuna: Add idle_state control functionality
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>
Cc: Wander Lairson Costa <wander@redhat.com>, "John B. Wyatt IV"
 <jwyatt@redhat.com>, Clark Williams <williams@redhat.com>, 
 linux-rt-users@vger.kernel.org, kernel-rts-sst <kernel-rts-sst@redhat.com>,
  "John B. Wyatt IV" <sageofredondo@gmail.com>
Date: Fri, 04 Apr 2025 17:50:25 -0500
In-Reply-To: <85674b73-2f87-7203-6384-664393da7133@redhat.com>
References: <20250311203034.8065-1-jwyatt@redhat.com>
	 <20250311203034.8065-3-jwyatt@redhat.com>
	 <erlhf5eul3ozro2maafv5josmrhd7xjzx7gue5ndjriabbmzgh@wcquadlmss5x>
	 <cb55cb771373e22a8a1f64c11bebbc42a8ac4034.camel@redhat.com>
	 <85674b73-2f87-7203-6384-664393da7133@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-04 at 16:36 -0400, John Kacur wrote:
>=20
> On Thu, 13 Mar 2025, Crystal Wood wrote:
>=20
> > On Wed, 2025-03-12 at 11:41 -0300, Wander Lairson Costa wrote:
> > > On Tue, Mar 11, 2025 at 04:30:19PM -0400, John B. Wyatt IV wrote:
> > > > +            "disable_idle_state": dict(dest=3D'disable_idle_state'=
, metavar=3D'IDLE-STATE', type=3Dint, help=3D'Disable IDLE-STATE on the sel=
ected CPUs.'),
> > > > +            "enable_idle_state": dict(dest=3D'enable_idle_state', =
metavar=3D'IDLE-STATE', type=3Dint, help=3D'Enable IDLE-STATE on the select=
ed CPUs.')
> > > > +    }
> > > > =20
> > > >      parser =3D HelpMessageParser(description=3D"tuna - Application=
 Tuning Program")
> > > > =20
> > > > @@ -127,6 +132,9 @@ def gen_parser():
> > > > =20
> > > >      subparser =3D parser.add_subparsers(dest=3D'command')
> > > > =20
> > > > +    idle_set =3D subparser.add_parser('idle_set',
> > > > +                                    description=3D'Manage CPU idle=
 state disabling (requires libcpupower and it\'s Python bindings)',
> > > > +                                    help=3D'Set all idle states on=
 a given CPU-LIST.')

s/it\'s/its/

> >=20
> > s/Set all idle states/Manage idle states/
> >=20
> > I still don't like the "idle_set" name.  This does more than setting,
> > unlike the standalone utility that we're apparently reimplementing.
>=20
> I agree that idle_set is not the ideal name since if you look at the
> cpupower tool, this is just one function, maybe cpupower would be a
> better name.  It's a bit unfair to say we're reimplementing the tool.=20
> The functionality is in upstream kernel code and John Wyatt created
> python bindings for that, and that is what he is using here.

But (as of now) this isn't using the python bindings to implement
something higher-level; it's exposing them as a command line tool that
has very similar functionality to the existing one.  I'm not sure what
being written in Python has to do with it, other than a motive for
reimplementing, to make future features easier.

> I think it is better to have all the tools for manipulating the
> environment through one tool and not make the user go search for
> multiple tools to get the job done.

"all the tools for manipulating the environment" is an extremely broad
mission... :-P

So far it doesn't seem to align very well with the rest of what tuna
does, which is managing processes/threads... is there a plan to tie
them together so that you can have it set idle states based on what the
tasks running on a given cpu need, and/or move tasks around based on
that?

> > Or just use "if cpu_list:" like the existing code does.
> >=20
> > That's also pretty obnoxious behavior of the code that sets
> > args.cpu_list...
> >=20
> > > > +        @staticmethod
> > > > +        def print_idle_info(cpu_list=3D[0]):
> >=20
> > This default is never used.  cpu_list is only ever set to
> > self.__cpu_list.  Why is this a static method?
>=20
> This is a different cpu_list than the instantiated one.
> This is which cpus the user wants the info from. I think
> the name is confusing here.=20

The only call (so far...) is literally "self.print_idle_info(self.__cpu_lis=
t)".

Where are you seeing a different cpu list?  When (even with future
patches) would the instantiated cpu list be anything other than what
the user asked for, and does that say anything about whether the class
design makes sense?

> > > > +            for cpu in cpu_list:
> > > > +                idle_info =3D Cpupower.get_idle_info(cpu)
> > > > +                print_str =3D f"""
> > > > +CPUidle driver: {idle_info["CPUidle-driver"]}
> > > > +CPUidle governor: {idle_info["CPUidle-governor"]}
> > > > +analyzing CPU {cpu}
> > > > +
> > > > +Number of idle states: {idle_info["idle-states-count"]}
> > > > +Available idle states: {idle_info["available-idle-states"]}
> > > > +"""
> > > > +                for state in idle_info["cpu-states"]:
> > > > +                    print_str +=3D f"""{state["Idle State Name"]}
> > > > +Flags/Description: {state["Flags/Description"]}
> > > > +Latency: {state["Latency"]}
> > > > +Usage: {state["Usage"]}
> > > > +Duration: {state["Duration"]}
> > > > +"""
> > > > +                print(
> > > > +                    print_str
> > > > +                )
> > >=20
> > > nit: I don't think we need three lines for this statement.
> >=20
> > Why not just print each state inside the loop, instead of building one
> > big string?
>=20
> valid, but I think John Wyatt was thinking the string could be=20
> useful for other purposes.

The json stuff I assume?  Is this even in the right format for that?
Is there any plan to json-ize other tuna functionality?

It's really hard to review patches when there are vague or unstated
notions of "this could be useful in the future"...  especially when
recent experience with rteval has highlighted the importance of
avoiding overengineering.

-Crystal

