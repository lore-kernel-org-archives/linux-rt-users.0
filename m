From: VITIELLO Fabien <Fabien.VITIELLO@esg-group.fr>
Subject: dbus and Preempt-rt patch compatibilty
Date: Fri, 7 Feb 2014 11:02:54 +0100
Message-ID: <37F7E221EAC4E34F8AA3DAB10BED6BDF3433BA640B@ESG-EXCH.ad.esg-group.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 16.156.206.91.webindustrie.fr ([91.206.156.16]:29304 "EHLO
	webmail.esg-group.fr" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbaBGKFc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Feb 2014 05:05:32 -0500
Content-Language: fr-FR
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear mailing list,
=20
I=92m Fabien Vitiello. I=92m working on a project which need to use dbu=
s under Linux kernel patched with preempt-RT.
=46ollowing the preempt-RT wiki, each RT application needs to have some=
 modification about Policy and Priority task concerning the scheduling.
https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO

In my project, Dbus will transfer messages with high priority for RT ne=
eds and others with normal priority for basic operations.
My question is: do exist a patch to DBUS to be compatible with preempt-=
RT extension in order to have DBUS as an RT application ?
I searched on the internet to find an answer but I didn=92t. This is wh=
y I=92m asking here this question.
=20
I really thank you for an eventual answer.
I=92m sorry if it=92s not the right place to ask this question. In this=
 case, could you tell me where to ask this kind of question ?
=20
=46abien VITIELLO
Ing=E9nieur d=E9veloppement / Software Engineer
=20
ESG Automotive France SAS
Centre Paris Pleyel, 153 Bd Anatole France
93521 Saint Denis Cedex
T=E9l : +33 1 55 87 05 70
=46ax : +33 1 55 87 05 79
E-mail : fabien.vitiello@esg-group.fr--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
