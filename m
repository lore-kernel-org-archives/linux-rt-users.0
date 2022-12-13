Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0FCC4332F
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Dec 2022 22:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbiLMWWk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Dec 2022 17:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236425AbiLMWWi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Dec 2022 17:22:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE972035B
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2022 14:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670970106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WEhN56oF7nkW6ZiEPXGS4RBEojBC47RBTismwXEbY9U=;
        b=DddA+4lznFh0uWrH52O9vyN95yXB4r2XoVHG/pjdUg/op9w64okIoL43Ivj/KUbFFux0Fh
        jYR6niOmTGb+SXkQya2JqtazPsn2EcsWUfmvOskj4RSAnld5QWib4IK9xxq93brVa3UrbG
        RcRfBZAmAnQRNtoF5H8yLtr6lDU2Y1k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-mxR7qeNMOo6s_Mk7TJM1aQ-1; Tue, 13 Dec 2022 17:21:45 -0500
X-MC-Unique: mxR7qeNMOo6s_Mk7TJM1aQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF10285A5A6
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2022 22:21:44 +0000 (UTC)
Received: from [10.22.34.151] (unknown [10.22.34.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E8F4492C14;
        Tue, 13 Dec 2022 22:21:44 +0000 (UTC)
Message-ID: <8842ea476d3e003bfc4659b1b79fd3fe97a67950.camel@redhat.com>
Subject: Re: [PATCH] oslat: Add command line option for bucket width
From:   Crystal Wood <swood@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
Date:   Tue, 13 Dec 2022 16:21:42 -0600
In-Reply-To: <71d7762e-720-fa73-96de-2e922b371e@redhat.com>
References: <20221209052254.2609767-1-swood@redhat.com>
         <1624dd34-d12c-38dc-aed1-a34366ceafba@redhat.com>
         <e1402a544c74b508b6d2b4cc644fce5909ccd863.camel@redhat.com>
         <71d7762e-720-fa73-96de-2e922b371e@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2022-12-13 at 14:31 -0500, John Kacur wrote:
>=20
>=20
> On Fri, 9 Dec 2022, Crystal Wood wrote:
>=20
> > On Fri, 2022-12-09 at 20:03 -0500, John Kacur wrote:
> >=20
> > > A quick first look through and run, see the one comment above
> > > near "case 'W'"
> > >=20
> > > and then
> > >=20
> > > checkpatch reports some minor easily fixed problems
> > >=20
> > > ../linux/scripts/checkpatch.pl oslat.patch=20
> > > ERROR: code indent should use tabs where possible
> > > #100: FILE: src/oslat/oslat.c:342:
> > > +^I^I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g.precisi=
on, us);$
> > >=20
> > > ERROR: code indent should use tabs where possible
> > > #102: FILE: src/oslat/oslat.c:344:
> > > +^I^I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g.precision, us=
);$
> >=20
> > I was matching the existing style in the file that tended to use spaces
> > for
> > alignment.
>=20
> Hmmn, when I run checkpatch on the file I don't get any other warnings=
=20
> about spaces, or when I look in vim I see tabs, maybe check your editor?
> Please fix the above when you submit a version two

I see it in a lot of the structure definitions and macros; looks like
checkpatch only cares if it's part of the whitespace at the beginning of a
line (which is not necessarily the same as indentation, but whatever).  I'l=
l
change it since you asked (it wasn't clear from the docs that checkpatch.pl
is the applicable style guide), but barring specific style guides or
pushback I tend to default to being kind to people using different tab
widths, having been one in a past life before the kernel beat it out of me.
:-)

> > > ERROR: spaces required around that '=3D' (ctx:VxV)
> > > #227: FILE: src/oslat/oslat.c:654:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0OPT_BUCKETSIZE=3D1, OPT_BU=
CKETWIDTH, OPT_CPU_LIST,=20
> > > OPT_CPU_MAIN_THREAD,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> >=20
> > I only added OPT_BUCKETWIDTH to the list; I didn't touch the =3D1 part.
>=20
> Yup, you're right, we're not as strict about the formatting in rt-tests a=
s
> the kernel is, and sure it will catch stuff that isn't strictly your faul=
t
> but I do normally run checkpatch on the patches. If you want to throw in=
=20
> the spaces around the '=3D' in your patch I'd appreciate it.

Sure.  As an aside, I do think that's a rule that is usually helpful but ca=
n
harm readability in some circumstances when applied strictly (e.g. "2*x + 1=
"
looks better to me than "2 * x + 1" which doesn't emphasize the order of
operations and doesn't provide the eye with as much structure).

> Now to the more important stuff, I like your patch, but I have a few=20
> questions.
>=20
> What if the user specifies a bucket-width greater than 1000?
> Is it meaningful to to have a bucket-width of 2000 for example?

Yes, that works and could be useful if you're trying to focus on larger
latency sources.

> If we have a bucket width of 1500, then we are going to have=20
> the same precision as if we specified 500?

Anything that isn't a multiple of 1000 will give you nanosecond precision.

-Crystal

