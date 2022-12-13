Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B17C4332F
	for <linux-rt-users@archiver.kernel.org>; Tue, 13 Dec 2022 22:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiLMWZH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 13 Dec 2022 17:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiLMWZG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 13 Dec 2022 17:25:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C84CC1
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2022 14:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670970258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOTtNGsi7qi8GNRLJZ1DWJU2jTaHTpBHPDrgTxYtOdU=;
        b=gCD1RXLsMdDVnrtkAKdddjz0XSzJ7L0vgeLC6YuU+qH7yUQWOsT0j+iVapBfrm0sAq80YX
        xAI5nMFi/XsyXUEGhYa21YoEQHVgzGdUOgh4uXLffVXY5r8PGpadG3HcOFqlGZjYNfAaAR
        aUw4/pVRipO7ItVY/2grjG6DPKXCp8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-EKTJvWV7Nv-qxALEupunzw-1; Tue, 13 Dec 2022 17:24:17 -0500
X-MC-Unique: EKTJvWV7Nv-qxALEupunzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E755185A794
        for <linux-rt-users@vger.kernel.org>; Tue, 13 Dec 2022 22:24:17 +0000 (UTC)
Received: from [10.22.34.151] (unknown [10.22.34.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C75ED51FF;
        Tue, 13 Dec 2022 22:24:16 +0000 (UTC)
Message-ID: <2dc379a7d42d8f758e7d6eeacdae0a1ef632d517.camel@redhat.com>
Subject: Re: [PATCH] oslat: Add command line option for bucket width
From:   Crystal Wood <swood@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
Date:   Tue, 13 Dec 2022 16:24:14 -0600
In-Reply-To: <b65defab-53af-bc4-8681-f3f982ed6c18@redhat.com>
References: <20221209052254.2609767-1-swood@redhat.com>
         <1624dd34-d12c-38dc-aed1-a34366ceafba@redhat.com>
         <e1402a544c74b508b6d2b4cc644fce5909ccd863.camel@redhat.com>
         <b65defab-53af-bc4-8681-f3f982ed6c18@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2022-12-13 at 15:41 -0500, John Kacur wrote:


> One more thing that we just saw, if you run oslat without any options,=
=20
> just the defaults you get 32 buckets with the highest one being 32us
>=20
> But if you run
> oslat -W 500
>=20
> You still get 32 buckets but since the width is half, then largest bucket
> is 32us
>=20
> This increases the resolution of the buckets, but it puts all the overflo=
w
> in the 16us buckets, wondering if we should double the number of buckets
> so that the largest one is still 32us ?
>=20
> I realize you could do
> oslat -b 64=C2=A0 -W 500
> to achieve that, but perhaps the default is not good like this.

Sounds reasonable.

-Scott

