From: =?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
Subject: [PATCH 0/3] rteval cross-distribution patch
Date: Tue, 23 Oct 2012 11:45:02 -0400
Message-ID: <1351007105-7852-1-git-send-email-raphael.beamonte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	=?UTF-8?q?Rapha=C3=ABl=20Beamonte?= <raphael.beamonte@gmail.com>
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50253 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757058Ab2JWPpj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2012 11:45:39 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so5480558iea.19
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Oct 2012 08:45:38 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Clark,

Here are the patches to make rteval working independently of the used
distribution.

Let me know if you have any comments/corrections,

-- Rapha=C3=ABl

---

Rapha=C3=ABl Beamonte (3):
  Rewrite of the get_kthreads method to make it cross-distribution
  Adds getcmdpath method to use which to locate the used commands
  Rewrite of the get_services method to make it cross-distribution

 rteval/rteval.py |   91 ++++++++++++++++++++++++++++++++++++++++++----=
--------
 1 file changed, 72 insertions(+), 19 deletions(-)

--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
