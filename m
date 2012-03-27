From: Robert Barrows <Robert.Barrows@metriainnovation.com>
Subject: Determining latest stable release.
Date: Tue, 27 Mar 2012 15:59:31 -0500
Message-ID: <CAOHJ0jQphT30v-y1HMiHYOnFVumovkccCV43mDJjBx=fko=GUg@mail.gmail.com>
References: <CAOHJ0jTVxzgfBK=GSEr14YrpFZEqFE_qDqftaUgGWDgm344NNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.ct23.fastbighost.net ([194.28.84.96]:40217 "EHLO
	ct23.fastbighost.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754403Ab2C0U7z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Mar 2012 16:59:55 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46])
	by ct23.fastbighost.net with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.69)
	(envelope-from <Robert.Barrows@metriainnovation.com>)
	id 1SCdUb-0007nW-7Q
	for linux-rt-users@vger.kernel.org; Tue, 27 Mar 2012 20:59:49 +0000
Received: by vbbff1 with SMTP id ff1so257411vbb.19
        for <linux-rt-users@vger.kernel.org>; Tue, 27 Mar 2012 13:59:51 -0700 (PDT)
In-Reply-To: <CAOHJ0jTVxzgfBK=GSEr14YrpFZEqFE_qDqftaUgGWDgm344NNg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Does the PREEMPT_RT patch have a method of determining latest stable
release?

I notice that 3.0.35 goes up to rt44 was declared a stable release but
so was rt43
Now 3.2.12 goes up to rt22, and that was updated March 23rd with 3.0.35=
-rt44.

Is there a reason to think that=A03.0.35-rt44 is more stable than=A03.2=
=2E12-rt22?
The real question=A0is: is there a rule of thumb on how you would choos=
e
a rt patched kernel for a production machine?

Thanks.

-Robb Barrows
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
