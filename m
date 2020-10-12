Return-Path: <SRS0=LljW=DT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DA4C433E7
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 18:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E6020878
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 18:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PO7Fkb60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbgJLSeI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Oct 2020 14:34:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:51345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgJLSeH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Oct 2020 14:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602527645;
        bh=0/fdAEZV/tHWAPU9uDx+YAkFj5Fp3/TX82ShMG98YB0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=PO7Fkb60zOZ8L2MR2hCRKEnsszxx7negBlcNha0OLtNbGuBlP7X6cJvcIcMdrhDbU
         xGQjWbPVQMr7b7i3f6ft7ERt1OAr4Hz/RILd4otX6gDMICv0f+whaRSBsenMTmL6p3
         64KYatBw566ehoquv7jopmxTSDMA3lVAGpIzgJL8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.248]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhuK-1kfmAB0Zhy-00DmsV; Mon, 12
 Oct 2020 20:34:05 +0200
Message-ID: <90459a197f5dad3b17ff8c484cc315c9b054f5c0.camel@gmx.de>
Subject: Re: [RT] 5.9-rt14  softirq_ctrl.lock vs listening_hash[i].lock
 lockdep splat
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Date:   Mon, 12 Oct 2020 20:34:04 +0200
In-Reply-To: <20201012164553.kkk7aaeyb3y4wvyh@linutronix.de>
References: <12d6f9879a97cd56c09fb53dee343cbb14f7f1f7.camel@gmx.de>
         <20201012164553.kkk7aaeyb3y4wvyh@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fw7ltThDyS4iAY3Hn92OrWWeFR4Ut7BebJLVDYfy/u2VEiGJS6L
 2fsVIVs3c469KCsAvfaLzr6Et93BQ4U6gaSrgpVv5YlyJ8yUauO0X+VVWLJBcp76jPSRTtk
 tIlLh7bJzpiz5V03XjAimJIFUbI502NUwWC6NIKLAQnVa8DQmJAPIeTz8Nr91qUeqVewBku
 3Y6NsTPgrcoW44V9Tt8lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X6Jsg76EVF0=:BBtZrtz7xVt1AC2PkSKAKT
 zgyPglF5TcZKlZezwyrWE4SQwVJbSTDUMSmhiTGqzu/GW87/aQxKjqOaa9/waUV1gnnDUuYej
 xeJbM7X2xRB66JsIHUUQWkB8NBFwxg1bhosK0krtngRfo9KyBFH1mN0FEIqdKyj3fOW6bigxk
 X5IC+IjzRf7nnaQ2wJjMLMqkBSwPuvDQMLoUPnrYh2j98XIjifRfz7SIgmQEG2dIRdVrp49B2
 10cPOgZsnM/xGDYs0tskprXtoUKTNRl5cgaXYBLhuwpxgZglYhe859Ot3bUxMjd/rinY/irtx
 Aq+U3n22h7HjdbZbf4ZysgJQrqRWbGgCDcF+jyl+hWIJGPQ6C6tRFk8mMPmOoUuWibQ3UZxPs
 SKmCsD6dSJP/M6qzybvsjZ+gtJW7GR9EZIKbPDG3ZJkDHy1AUpT72dJFzgxBnzjqfVVaBSv5L
 Hai3Eakp3qIxl9YcRZjgKoHHxqLxOv0fNetW6m7RVlZajyzZXmT3aVF79j8y+8o+Lf8nmFVUj
 KEr/fZ3C47S/xdFH6UQA1xNxjGyyLSkpjXLESDmAINXZ1+1gsWcQY37aOyAIOdkZhlCSr1IKv
 ADY0jxJnnmaMua+KTgGw/kWtsJcMSbnnJ5f2nIkQjg3r2S8qsram9MUYrTnUbDhwUAvZM24CN
 yQIeXVI573sLdTv6grfRl/iZ/HDjzkUyomrBKjWJoNTDTAEhfUqNbpL/GAeQgaXdv3CcCBinE
 6tvRC7Vso++sKHO8Ezp3BBaBGqJFH++IxXF36XUQFtDegm+9KuQexw0j5UKk20rcpcVQ6g2bt
 QkWQRvVvSlPPXEB8hubU+w7zY1RzlzLycY+cABJ4mb4kh5MaVWwZ/ffnoSmw2lMH7u7j60+nb
 H33x8TpA8onxEknnzWNEJKWyNOSa+mB0lrbD6q+2IyH21knXMVGAmJpnE8jKN+3Hu61Uijkjn
 No8cVKhmqvoAFtlX8fQEG4M0pscdGt/37Ws4a8Oa6uTe/8xS75Le12qkJWxSryWCVWIOdkY7x
 jF5QTtnxRkC+Y2gOFA2XOegnkN/7jq1C5YUBfyecz87gZhwfp6jGzxnYlbsmi2N6ZdOemxgyV
 hmZMoJd+epowJBNsSQx1pK8CUUJx25R1xbRhxn8GKBdRwoDz+cC2SvqbEnwd3t/3ghasytYlW
 vOL4EDuE2YfvMTHHgdtFHCPEwYp31D++orw4Aroxwq8obo+nFg6Qrhj9Wz+vzQslgupS1BN70
 UyhLSobYLAQUZ73zN
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 2020-10-12 at 18:45 +0200, Sebastian Andrzej Siewior wrote:
> On 2020-10-10 06:31:57 [+0200], Mike Galbraith wrote:
>
> so this then. Do you have more of these?

Nope, nothing was hiding behind it, all better now.

