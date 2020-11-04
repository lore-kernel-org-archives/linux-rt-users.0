Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8256C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 21:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86BC320780
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 21:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJ+dUpr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbgKDVzz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Nov 2020 16:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42648 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729913AbgKDVzz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Nov 2020 16:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604526954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4sJ1+ZFRDoRh1U2ROR74/zRv5gNE//jc/8rF+RAwWg=;
        b=FJ+dUpr9JiWvpZGiF/qgOyH/6/B2g4yE5hsUa8m/qEAbpSryOwXchemOfSOK8XA2wY+NF1
        rMndB2gmhywtIdET7TMpD0+/EczH4RPWRdDtudDph/xSIeiqobXGYqNqFHuOCRLuqmhF71
        urWIOjevxETE1QBteUF/TFHdGjZij6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-UB1VdKnjNiWU-N4Q_4y_jg-1; Wed, 04 Nov 2020 16:55:52 -0500
X-MC-Unique: UB1VdKnjNiWU-N4Q_4y_jg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEFFF10054FF;
        Wed,  4 Nov 2020 21:55:50 +0000 (UTC)
Received: from theseus.lan (ovpn-118-74.rdu2.redhat.com [10.10.118.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52C9E5D98F;
        Wed,  4 Nov 2020 21:55:50 +0000 (UTC)
Date:   Wed, 4 Nov 2020 15:55:43 -0600
From:   Clark Williams <williams@redhat.com>
To:     "Brown, Thomas" <thomas_brown@mentor.com>
Cc:     <jkacur@redhat.com>, <linux-rt-users@vger.kernel.org>
Subject: Re: Problems with the priority flag for signaltest and sigwaittest
Message-ID: <20201104155543.7e4b3668@theseus.lan>
In-Reply-To: <e2dc04e9-f465-972d-9140-c20dc6adf0bc@mentor.com>
References: <e2dc04e9-f465-972d-9140-c20dc6adf0bc@mentor.com>
Organization: Red Hat, Inc
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=williams@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/RkYcGjKqbKAKxU6SVh=oX+G";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--Sig_/RkYcGjKqbKAKxU6SVh=oX+G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Nov 2020 10:54:23 -0500
"Brown, Thomas" <thomas_brown@mentor.com> wrote:

> Hi there,
>=20
> We are experiencing issues with the priority flag set for the following=
=20
> tests on separate platforms...
>=20
> signaltest -p99 -l100000 t4
>=20
> |sigwaittest -p80 -t4 -l100000|
>=20
> In the first case it appeared when debugging with gdb that a thread was=
=20
> not joining or terminating properly and the kernel blows up=20
> spectacularly with many oops and traces.
>=20

What architecture and kernel versions were you running on?

> In the second case it is difficult to retrieve any debug information.
>=20

Were you running kernels and rt-tests binaries that you built or were you
running distro provided images?=20

By "difficult to retrieve any debug information" do you mean that you could=
n't
get debugging symbols or that gdb wouldn't show symbolic information?

> Please let me know if there is any insight into these problems or if=20
> there is a better contact for resolving these issues.
>=20
> --=20
> Kind Regards,
>=20
> Thomas Brown
>=20
> Linux Developer
> EPS PBU RT Solution Services
>=20
> 411 Leggett Drive
> Suite 502
> Kanata, ON, Canada
> K2K 3C9
>  =20
> Tel: 613-963-1016
> Fax: 613-599-1060
>=20


--=20
The United States Coast Guard
Ruining Natural Selection since 1790

--Sig_/RkYcGjKqbKAKxU6SVh=oX+G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQR0YdLf0YpOOtg8/Kl2UGrcL65k9wUCX6MjXwAKCRB2UGrcL65k
9+dGAQDTKKhjH82DDbMI5lGgtTqnuQrg1MdOQAWPOjXZyPm1WwD/YgzzulQCzbWm
CKb4piSBjDH2XDx33SNrzE1ojMMz8Qo=
=0w3i
-----END PGP SIGNATURE-----

--Sig_/RkYcGjKqbKAKxU6SVh=oX+G--

