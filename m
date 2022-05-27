Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CC1C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 May 2022 16:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244067AbiE0QOe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 May 2022 12:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbiE0QOe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 May 2022 12:14:34 -0400
X-Greylist: delayed 34613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 09:14:30 PDT
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:488:66:1000:2ea3:7291:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A7E11E1ED
        for <linux-rt-users@vger.kernel.org>; Fri, 27 May 2022 09:14:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B71C5DA1D;
        Fri, 27 May 2022 18:14:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1653668063; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=JSEfviWt60CdE5gpETXZHv524PWGqUbiXGaDZQ39gUQ=;
        b=H6mzTainTm+qNNhDUAI6Tegn8C9lUcp9r0S4H+GamMT3SXnQH4k49URAdP+d1meO4evIaF
        qyPhLWnmWPCASGrhQdKbHSkb7qr/W6NbVzIKIVoOgtAdBxoegPEvFqlI/FeC7XFACikA3O
        d2/LauMbIKZomJUKf1njVnK+liESOoIyYNOT9p4qHhBC0j9k2QDVi3ZNPoVlr9W8fJsG2D
        FU8V8dGIBwTgnGv/8j6KV8tyInyMDQRpMXOTSvUrmLSjI0KxqAe70YP6a+ok9LqEYm8w3z
        XJWN1wlA3Ufu83ShorsZCjt+QHZX9xwhiz8NoukQUClF8Y53/QfBkBv2FsNiVQ==
Date:   Fri, 27 May 2022 18:14:20 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Xenomai <xenomai@xenomai.org>
Subject: Re: [ANNOUNCE] High altitude realtime workshop 2022 edition
Message-ID: <20220527161420.hr5sxxqepuhjeqoi@carbon.lan>
References: <5c1e1916-6966-f54c-6af5-ad06ac945718@monom.org>
 <CAFLxGvzxBSaqFAMUzBVfAwWdHgARxZP5MaeQXUpWUPV6ypETvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLxGvzxBSaqFAMUzBVfAwWdHgARxZP5MaeQXUpWUPV6ypETvA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Apr 19, 2022 at 10:23:07AM +0200, Richard Weinberger wrote:
> On Tue, Apr 19, 2022 at 9:59 AM Daniel Wagner via Xenomai
> <xenomai@xenomai.org> wrote:
> > What: High altitude realtime workshop 2022 edition
> > When: 2020-06-05 to 2020.06.07
> 
> Whoops, old date.
> 10. June to 12. June 2022 it is.

Here some more details about this event (hint if you want to attend
please let us know).

The first meeting point is at Innsbruck HBF. Meet at the meeting point
at 11:20 on Friday. It is located on the lower level, which is the same
level as the underpasses from the train tracks. From there we take the
bus towards Tulfes at 11:40 (Bus line 4134 [2]). Richard and Ines will
be there. If you have trouble finding the meeting point, you can text
Richard.

The second meeting point is at Tuxerbauer, Schmalzgasse 5, Tulfes 6075
Österreich around 12:15 (Bus arrives at this point). Before we start
with the hiking we make sure everyone is properly stuffed with local
specialties.

Then we will start with our hike. The more sportive ones can do the
whole hike to the top, the other ones use the chairlift for the first
section. Please let us know if you want to take a different route than
we take.

On Sunday, we will start the day with a nice breakfast at the lodge and
then decent. On the way down we have a lunch break before we get back to
the parking lot of the chairlift. The expected arrival is around 14:00.

Christoph Hellwig
Daniel Wagner
Richard Weinberger

[1] https://www.bahnhofcenter-innsbruck.at/info-service/lageplaene/
[2] https://www.verkehrsmittel.info/app/download/16007988524/4134+12.12.2021.pdf?t=1646749460
[3] https://schnaps-brennerei.at/
[4] https://www.glungezerbahn.at/ 
