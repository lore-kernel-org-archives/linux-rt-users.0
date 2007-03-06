From: "Samuel Ortiz" <samuel-jcdQHdrhKHMdnm+yROfE0A@public.gmane.org>
Subject: Re: 2.6.18-rt6 IrDA strangeness
Date: 6 Mar 2007 14:22:46 -0000
Message-ID: <FvWAtRUd.1173190966.6915950.samuel@sortiz.org>
References: <Pine.LNX.4.63.0703061503540.534@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
To: gl-o/hVf8ie6tKzQB+pC5nmwQ@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	irda-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <irda-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.63.0703061503540.534-pjC7uWgG1yLsj6RlE8knwQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/irda-users>,
	<mailto:irda-users-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=irda-users>
List-Post: <mailto:irda-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:irda-users-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/irda-users>,
	<mailto:irda-users-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: irda-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: irda-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org


On 3/6/2007, "Guennadi Liakhovetski" <gl-o/hVf8ie6tKzQB+pC5nmwQ@public.gmane.org> wrote:

>On Tue, 6 Mar 2007, Guennadi Liakhovetski wrote:
>
>> Ok, just tried 20-rt8. Of 3 problems described earlier the first two:
>> non-working syslog(2) and irdadump showing packets only in one direction
>> are now gone. Whereas the third one:
>
>[...]
>
>> is still there.
>
>Ok, I also managed to reproduce this with non-rt kernel, so, it's just
>some incompatibility between 2.4 and 2.6... Might be considered as a nug
>on the 2.4 "reference" side.
If you don't see the problem with two 2.6 peers, then it's definitely a
2.4 bug...Have you tried that ?

Cheers,
Samuel.

>
>Thanks
>Guennadi
>---------------------------------
>Guennadi Liakhovetski, Ph.D.
>DSA Daten- und Systemtechnik GmbH
>Pascalstr. 28
>D-52076 Aachen
>Germany
>
>-------------------------------------------------------------------------
>Take Surveys. Earn Cash. Influence the Future of IT
>Join SourceForge.net's Techsay panel and you'll get the chance to share your
>opinions on IT & business topics through brief surveys-and earn cash
>http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>_______________________________________________
>irda-users mailing list
>irda-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>http://lists.sourceforge.net/lists/listinfo/irda-users

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
