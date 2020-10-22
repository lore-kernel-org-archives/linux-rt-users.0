Return-Path: <SRS0=0dn7=D5=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633B8C388F9
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 14:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49B2241A3
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Oct 2020 14:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JYADd7hm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368186AbgJVOr6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Oct 2020 10:47:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:60163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368185AbgJVOr5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Oct 2020 10:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603378041;
        bh=8XvDtZqBGMjE1MMEGr+Srw59aaxKG7TA5qlDqNmNCbQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=JYADd7hmKPcT7g6gJBdm97B1g7gig6gGgmsyBcVt/B1soRxEAJJkwe4l9WBBfwP5U
         HDA423Wl2ep+p7byMAnmcRl3qhVJbzaaO9wgMjOsYbmURwoLwPdpDATkxI4Mu4tJgb
         ZEZCdQCFeUojseR1bbPXzB1Fb54mUYZl7jLZQA9Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.221.150.153]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE6F-1kpjxD3wZ1-00KkT6; Thu, 22
 Oct 2020 16:47:21 +0200
Message-ID: <c2965ef22b5e95db0d9e214efb6f653628549579.camel@gmx.de>
Subject: Re: printk: add pr_flush()
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Thu, 22 Oct 2020 16:47:20 +0200
In-Reply-To: <43c56d9bd7c5d0b7c455a5ba3c00080b1600b718.camel@gmx.de>
References: <15cd3dc322eb1485fe1e67df465febdc6ad389d8.camel@gmx.de>
         <20201022141529.zvwafoqglnhyklj5@linutronix.de>
         <43c56d9bd7c5d0b7c455a5ba3c00080b1600b718.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v0FyWnDrgqAsnVJdTRCvHrnMxr79H75bONeGijAINn0ChPSo9pJ
 QGhhaiEhlDjtI4E/+tsW492gPZvvszvp+1b8CivkKDOxSsc2iASFiQKq+MuZ/7gWrWKouY0
 h/oJ1oPbfXjMKkWxm+ClIBqSLLDL7yQ85G8PCsQMK4GBvwjY7fuUje4hXPlI/T7Nb/P6n1P
 jlC58eZ659F21KrlqzhrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o63PqROPc0A=:Ruf6Xuvo1q9kFbmFkXecE7
 o0pGjVBpOvBka/8GnHxDFLcmYBdMRxb6+Y/EEky0Sc52Qy8IELLq+UnCVckjkMEMEJ6+XGTqC
 0aqP1CzXUsn2Pp55xGBE9CZVHDH4b31R+e675cY8XJCk6WlN3cb9SBODXljcU8tirtV2fjYc6
 4sdcUwktn7pm0fZrfQT1jbFOnYWKB8Mz8lcp7cR5gZ8OVYhdpaR8f5faao9aG6wt2Xpd8xM8K
 4v9ItAII5EDd8pkdG0GW/JGPpV63586Tr3Q2lVpsPItbqfDCn1UBH9EKd+tdK96Wx3PBU3vT9
 ScwHLw+B4vueX+Js4eXo37k4BIClLduRfEe5oDOEv/t0LVSdyDnNe835MoiKEq8u3a9jPOu7w
 KIJhGJEepJrSAbRdky/qq/hdKWS/8/IItPKoZXxCOLdQ+Eeg7tQQ5xhWLORXQ64h6lZicFYp+
 Rn9/fqD3hMayDxHSzGBh2Y0yyoSLx6v8u1oBMc0jmumhWV8tN3B25q98IvW7oVVzbxybf0O1Z
 QeaWWiqqkAKopasq8RZaTrHZnDBwtp8O0IdQA42YLG7UMJUiWpFhXrqyzcPaf+gLTU9Lu/Km9
 KHNjHGYSuu8/t5IGUJ+EXY+K/TRsPvaeIR2YWtVb1210FiwE+5lCRGdcDki7oc6aJ7/PYEo8W
 vCH+l1Yq+63/1CXc7hjDZMiIW8Uef1zU023exSAzse0Br2HvzNzlYzZOvK1hy5DqNwaQRpWm6
 ZE+JLYHG60DxKP4q21j4Od1TZW/D8ehUUz1rBjSIum4fsDfSBsZIrfvPuPZZ+EHiHAESwIUn9
 jnYTZlwpQnntuKGKGa6fMr11Qe6Tcg03Sdn3an7cGdflU2VdG37tIE2FRDqZKz8B+zdRDJec1
 7LnHrNppsYFxv1zaPLEA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-10-22 at 16:36 +0200, Mike Galbraith wrote:
> On Thu, 2020-10-22 at 16:15 +0200, Sebastian Andrzej Siewior wrote:
> > On 2020-10-22 16:12:41 [+0200], Mike Galbraith wrote:
> > > Greetings,
> > >
> > > Seems this patch can cause hangs.  I can reliably reproduce one such
> > > hang by poking sysrq-b, and it goes away if I revert that.
> >
> > does it still happen if the wait argument is `false'?
>
> Yup.

Um, that "yup" is predicated upon you meaning reset_on_progress, that
being the only bool.

	-Mike

