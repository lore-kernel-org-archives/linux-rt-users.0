Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56683EB64D9
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jun 2023 16:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjF2Q5p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Jun 2023 12:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF2Q5o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jun 2023 12:57:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE182D4C;
        Thu, 29 Jun 2023 09:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E8F0615A9;
        Thu, 29 Jun 2023 16:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B82EC433C0;
        Thu, 29 Jun 2023 16:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688057863;
        bh=duJXJuih7Fd3L+sgCuJfNa9TCg06mFFsR8D0muRvx2Y=;
        h=Subject:From:To:Date:From;
        b=KCaKLksZdZg9s6mxr5KI3lnYwYA0JOF+TZ72sjdhCupspwO+h8LaTByFjuW+dqiRA
         ScXv+ABQj7tfqDVaYIWXqDL3MA9kR8CunaiMvTCiBQLliAhoZ40ZwxOe6OQTPCwAJ2
         uQHkXtrW0GsiQgQA9pRJEr45ym84Xr3F8fJrVIAcSW9QdbRlpkbUAJSY71moK8npvt
         y+q9kE413xrqHHC7txDk8SSw0rxCr+ys6K4iF3PgV3Q14AZSlcVfGx5Rf2M5pCVaKT
         V2UB1Os72lf6/CqecRKR5u6gazpwAXHMxo0eWX6Iko7nBFP/X8cKLE78C/FzOWC2XD
         U1udr4XAcGYCA==
Message-ID: <b90fda7ccdf3b2bc821d42bf54b857a041009a38.camel@kernel.org>
Subject: [ANNOUNCE] 5.4.248-rt83
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Thu, 29 Jun 2023 11:57:39 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 5.4.248-rt83 stable release.

This release is just an update to the new stable 5.4.248
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: b7c31a429c09685c2e24d64c119370a78cec1207

Or to build 5.4.248-rt83 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.248.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.248-rt8=
3.patch.xz


Enjoy!

   Tom

