Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6054E13A244
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Oct 2025 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942219; cv=none; b=cW8KW4wDfhyz7n2qEDcF7ohiPyGWQLiOTLZKZvUqjTbZcC4IQL3JmSlwHvJvfISg4jTdlNjvLej38Faobw7pE6iVrS0+fwcsa7a1cZklAo3eBkOkf7t9mMwLYioZxFVtMjEbFlScu1oM+0MJlbYS74tkt7ACgoDiFr4TwM3ROGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942219; c=relaxed/simple;
	bh=AHnT1nh8tcYlpo3IV2m60zhcD2r8W5XI8rbXRhy6P2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FKpSEGG1prGRbmMttWFzTEi3LXr4pSbUsaqeTfNq3O9AfBMkAkED6GkH0Uyb/U2l3Wm+q3huiyZu9vxBDN8OuWU61OSbU4Ie9IVaTslXiRmJpuhcKocwbF/XMsfQvaindcpf454827q9wLiXGJNnBm1L5RZp1YnXcVNJah28wzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9ib6HuF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9ib6HuF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759942216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HznssufIeYzxpj/6/IFE1Qt8LCsksbycl22tMx+iyis=;
	b=K9ib6HuF4kypF+aXEw2+mwggw9moGH3QNl9gVvcvBi5g1j1kpr+RdSLMPLb7G5TYInPmEO
	w9DXnsJgE6u6pSrdmGXy9qTk3MSNfKe+jkpL1lWKMo75A7Hz68qQg328n3XHOlc0JOrQqO
	DE/HKcb5vx+KAf/1/qevdRv7FGGlrV8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-Vt3_oY-SOz-jhWBocQ4bUA-1; Wed, 08 Oct 2025 12:50:14 -0400
X-MC-Unique: Vt3_oY-SOz-jhWBocQ4bUA-1
X-Mimecast-MFC-AGG-ID: Vt3_oY-SOz-jhWBocQ4bUA_1759942213
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4df60ea7a1bso169841471cf.2
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Oct 2025 09:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942213; x=1760547013;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HznssufIeYzxpj/6/IFE1Qt8LCsksbycl22tMx+iyis=;
        b=hs8HnnrGRf0jIb0hPsObAXzTC8ktCFVHljty5K0FbbldXHeK/W1OVXY8EaAE3OVI2z
         PmgqKtJCdbo+tUzwJi4Rzir2n0nRgDX3zhOvZoPOXnNvQKKdrDriR2gN8MJmrr9lKFnQ
         keieBivDug+OJ9/uHSFvwK1ilmhuhb7NvEM5DzjfVQgyu2dQn/Ftcy2xmLKne9jZdBv3
         6tgAnnAUOVCwDZEXHLSWsSWDBGeDG5RD8epeaK/H5QGJ4neOHfymJVTQZZzauO6CRMiE
         5Kil6E7mTrcqqPBfsWJlzMNDS3Be5apLZK8dKJKO/hf3wTRkkKt637Q/x0kYYuI6AlD7
         oDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkDwjUu4oCMDHjOhaE5aWNksils76L6d23tKOhoqB8VIPu4AlXqf99FgYal+lpo74yUIbxQvvWMEScugZweA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwczrLXWXhSLTAfKo/ERXvB5WWvufC6tRHjc63oTA3DUOwHc36Z
	xcbKqqFy5oeHd/MpF7CsQyxEqDTukuMmjn4jhFlydNFhLIYpzmBb1mvtTf7Ni6vakNziIynmHwf
	3QdUBe5/V1UCu/d8AwWnV7zDMnXChfJ5xStL71rsm+8YhGPXD/soN8OVZbidi/0jZFOGW
X-Gm-Gg: ASbGncuCFdusQLiw1F/Cr8zcLROlSauDouZGdTbVVxDgmtKKdR5dsubrBB0TrPOpIXc
	MksOs24LEqbY3Zc4YKUf/NexgL1dAqzWxS2LRHcEk9WWhorOZ4PmFHTvxY0V31mtMa9LwRmdZEz
	oBk3dNWMC4KKhImjYzMt2Qg0bHXbhvYiwUVHan7whglkRCEGpl5zhQstlJbELts0eueTApk+wGC
	Y/baZ8vsBQxPGYW7YRrz3g+H36Sww/aURGmHbQ/TZqabT6GGnreRhc0Jg8SmiJqSGVmU+0yrDhV
	c2yh6fWITZ/DfbFx07QKJnHOkhT41FMeVtiT1JKpYMS8eyVVolmS7uYo8IjLSPYgISBxKUlQwss
	1MQ==
X-Received: by 2002:a05:622a:1492:b0:4dd:e207:fd0 with SMTP id d75a77b69052e-4e6ead694f8mr60098641cf.74.1759942213322;
        Wed, 08 Oct 2025 09:50:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm+sz6UIi5OvlXa+QfFX7fhYP5dTnSqH2wsxxq+icrmHvQ/b4ODoOmXyHLLGPcQmPaX532MA==
X-Received: by 2002:a05:622a:1492:b0:4dd:e207:fd0 with SMTP id d75a77b69052e-4e6ead694f8mr60098211cf.74.1759942212891;
        Wed, 08 Oct 2025 09:50:12 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2369a0dsm20293685a.48.2025.10.08.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:50:12 -0700 (PDT)
Message-ID: <6eef31238e5c8ee18fee7dbc1cf250bd30892941.camel@redhat.com>
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
From: Crystal Wood <crwood@redhat.com>
To: debarbos@redhat.com
Cc: clrkwllms@kernel.org, linux-rt-users@vger.kernel.org, wander@redhat.com
Date: Wed, 08 Oct 2025 11:50:11 -0500
In-Reply-To: <cyk7iyu5rn72ppngwax6xn2nzgsyl5x2w5xjwj5aowmcw2ximv@cpxbkerjod3s>
References: <20251002205515.1299816-1-debarbos@redhat.com>
	 <20251002205515.1299816-3-debarbos@redhat.com>
	 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
	 <cyk7iyu5rn72ppngwax6xn2nzgsyl5x2w5xjwj5aowmcw2ximv@cpxbkerjod3s>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 09:07 -0400, Derek Barbosa wrote:
> On Tue, Oct 07, 2025 at 01:50:57PM -0500, Crystal Wood wrote:
> > On Thu, 2025-10-02 at 16:55 -0400, Derek Barbosa wrote:
> > > Also, disable Intel CET -fcf-protection and BPF support, remove
> > > annocheck targets, and default to the c99 compiler (if present).
> >=20
> > How are these related to the kernel version?  And I don't see any
> > changes to annocheck.
> >=20
>=20
> If I am not mistaken, CET [0][1] is fairly recent. Attempting to build wi=
th this
> flag on a RHEL-7 box (I need to check the gcc version again) was met with=
 an
> "unknown option".

OK but that's a GCC version issue, not a kernel version issue.

I still don't get why we only use c99 for legacy builds... does
something in the non-legacy build need a newer standard that is now
default?

> > > Signed-off-by: Derek Barbosa <debarbos@redhat.com>
> > > ---
> > >  Makefile     | 40 +++++++++++++++++++++++++++++++++++++++-
> > >  src/stalld.c |  6 ++++--
> > >  2 files changed, 43 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/Makefile b/Makefile
> > > index 7234a46..c09d574 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -9,6 +9,14 @@ ARCH=3D$(shell uname -m)
> > >  endif
> > >  $(info ARCH=3D$(ARCH))
> > > =20
> > > +LEGACY_VER :=3D 3
> > > +ifeq ($(strip $(KERNEL_VER)),)
> > > +KERNEL_VER=3D$(shell uname -r | cut -f 1 -d .)
> > > +endif
> > > +$(info Kernel Major Version is $(KERNEL_VER))
> > > +
> > > +IS_LEGACY:=3D $(shell test $(KERNEL_VER) -le $(LEGACY_VER) && echo "=
true" || echo "false")
> >=20
> > What happens when we need to test for a feature that isn't even loosely
> > associated with 3.x versus 4.x+?  Why are all these things being lumped
> > under one vague "legacy" label?
> >=20
>=20
> What other features would we be testing for, outside of the ones disabled=
 for
> compatability purposes?

I just meant that lumping all compatibility flags into one big "LEGACY"
made me twitch. :-)

If we're going to do that anyway (e.g. to simplify testing) I'd at
least have a comment indicating that this is being used as a heuristic
for older systems in general to avoid the need for a more complicated
build system (at least for now), to save readers some head scratching.

> > > +ifeq ($(IS_LEGACY),true)
> > > +$(info Compiling with Legacy Mode enabled)
> > > +$(info Overwriting RPMCFLAGS...)
> > > +CFLAGS	:=3D	-DVERSION=3D\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(=
DEFS) -std=3Dc99 -DLEGACY
> > > +endif
> >=20
> > It's overwriting CFLAGS, not RPMCFLAGS.  And if both RPMCFLAGS and
> > LEGACY are set, it looks like this ignores RPMCFLAGS.

I think my confusion here was that it's overriding rather than
overwriting.  If we do end up doing this, a comment explaining why
would be helpful.

> >=20
> > Why is SOPTS dropped?  The closest thing I can see in the changelog is
> > -fcp-protection, but that's part of FOPTS (along with many other
> > things).
>=20
> ```
> SOPTS	:=3D 	-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
> -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1
> ```
> When building on RHEL-7, it was though SOPTS still make their way through=
, even
> though the comment specifies that these are variables that only come from=
 the
> specfile for DNF-family distributions.I was getting errors due to annobin=
 not
> being present, so I stripped it out.

Oh, I was looking for "annocheck" which explains why I didn't notice
that.

So the issue is that when you *are* building an RPM, the specfile isn't
passing the right things for that OS version?  Wouldn't that be an
issue with the specfile?

> > > @@ -221,3 +240,22 @@ tarball:  clean
> > > =20
> > >  annocheck: stalld
> > >  	annocheck --ignore-unknown --verbose --profile=3Del10 --debug-dir=
=3D/usr/lib/debug/ ./stalld
> > > +
> > > +help:
> > > +	@echo  'Cleaning targets:'
> > > +	@echo  '  clean            - Clean the main executable, tests, obje=
cts, and tarballs.'
> > > +	@echo  ''
> > > +	@echo 'Building targets:'
> > > +	@echo '  stalld            - Build the main executable (stalld).'
> > > +	@echo '  static            - Build a statically linked executable (=
stalld-static).'
> > > +	@echo '  tests             - Run tests in the "tests" subdirectory.=
'
> > > +	@echo '  tarball           - Create a source tarball: $(NAME)-$(VER=
SION).tar.$(CEXT)'
> > > +	@echo ''
> > > +	@echo 'Installation targets:'
> > > +	@echo '  install           - Install the executable, man page, docs=
, and licenses.'
> > > +	@echo '  uninstall         - Remove all installed files.'
> > > +	@echo ''
> > > +	@echo 'Utility targets:'
> > > +	@echo '  annocheck         - Run the annocheck security analysis to=
ol on the stalld executable.'
> > > +	@echo '  help              - Display this help message.'
> > > +
> >=20
> > This seems unrelated?
> >=20
>=20
> Sorry, I am unsure what you're referring to. Are you saying the addition =
of a
> `make help` target is unrelated?

Yes, it seemed like something that would normally be a separate
patch, though that may be me getting stuck in kernel development mode
:-)

I wouldn't have mentioned it if the patch didn't feel off in other
ways.

-Crystal

