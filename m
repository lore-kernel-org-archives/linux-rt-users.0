Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A815C4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Mar 2022 09:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiCRJq5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiCRJq5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Mar 2022 05:46:57 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220842E7132
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Mar 2022 02:45:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7FA45D49A;
        Fri, 18 Mar 2022 10:45:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1647596736; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=eYVdezYFAKeIi4ILI71hiYTwrTUdKfY7hxRlR5ExPWI=;
        b=hJOuJuYJlf74pZLmfaOX5VW5hIJyqztFOv/8uR52/sFGsnokKeUHv8qZATl2EuSN4rSlnA
        ndy6FUtWvtQlsbdRXAWx7mclmmbIuMtp4OD9pv4OtLWSUWkFQFGxc6snoPtcgCbp5vMfy0
        rdCJ9zaIo+G/E7XmBgStONVAYyuoV50hYhrM8JCgOPDiXjEtG5m2eed3I5QKXKicZzqeAY
        qvnW8GGIe1gaSjgkuwZoct/+X3WeAhNgFUJ8HqqHbSjqJx1ZzsN9s2zvxlBKinLUF9un6+
        caC+lDTUaBeHcis2RbwSjeLVe0+7RRlNbECsYhnvZEfezu1L7TANjz7xE99JCA==
Date:   Fri, 18 Mar 2022 10:45:35 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] 4.19.233-rt105
Message-ID: <20220318094535.azlclmxubdbmusss@carbon.lan>
References: <164698646082.13723.1987519373498826881@beryllium.lan>
 <20220318060151.411f6789@archlinux>
 <20220318084800.6f5xs4rnp5kw6lxo@carbon.lan>
 <20220318102051.483333f2@archlinux>
 <20220318102718.1347247d@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318102718.1347247d@archlinux>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Mar 18, 2022 at 10:27:18AM +0100, Ralf Mardorf wrote:
> >I can't find the key
> >
> >1B45744BE36280CA7D6BD460E072D068B1F5703E
> >short                   E072D068B1F5703E
> >
> >at
> >https://kernel.googlesource.com/pub/scm/docs/kernel/pgpkeys/+/refs/heads/master
> >
> >*?*

$ git clone git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
Cloning into 'pgpkeys'...
remote: Enumerating objects: 24, done.
remote: Counting objects: 100% (24/24), done.
remote: Compressing objects: 100% (21/21), done.
remote: Total 5391 (delta 6), reused 0 (delta 0), pack-reused 5367
Receiving objects: 100% (5391/5391), 16.69 MiB | 6.38 MiB/s, done.
Resolving deltas: 100% (3045/3045), done.

$ gpg pgpkeys/keys/587C5ECA5D0A306C.asc
gpg: WARNING: no command supplied.  Trying to guess what you mean ...
pub   rsa4096 2011-10-05 [SCEA]
      5BF67BC5082672CABB45ACAE587C5ECA5D0A306C
uid           Daniel Wagner <wagi@monom.org>
uid           Daniel Wagner <wagi@kernel.org>
uid           Daniel Wagner <dwagner@suse.de>
uid           Daniel Wagner <daniel.wagner@suse.com>
sub   rsa2048 2018-01-07 [S] [expired: 2020-01-07]
sub   rsa2048 2018-01-07 [E] [expired: 2020-01-07]
sub   rsa4096 2019-08-04 [S] [expired: 2021-08-03]
sub   elg4096 2019-08-04 [E] [expired: 2021-08-03]
sub   elg4096 2021-09-07 [E] [expires: 2022-09-07]
sub   ed25519 2021-09-07 [S] [expires: 2022-09-07]

Isn't this enough?

> Actually I don't want to upload something, I want to download the
> needed key to verify the rt-patch. It's not available by any public
> key server I used when trying to get the public key.

The wording might need some clarification. I asked Steven for advice as
non native English speaking I tend to cause chaos with such things. In
short, to upload the artifacts to korg we need to sign the files. The
same key is used to sign the tags.
