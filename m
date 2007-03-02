From: Guennadi Liakhovetski <gl-o/hVf8ie6tKzQB+pC5nmwQ@public.gmane.org>
Subject: 2.6.18-rt6 IrDA strangeness
Date: Fri, 2 Mar 2007 15:11:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021500020.1799@pcgl.dsa-ac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, irda-users-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <irda-users-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi

Ok, the kernel is a bit old, but maybe someone has an idea... Running ppp 
over irnet, one side with the above kernel, another is a verified 
reference system. The following strange fenomena are observed:

1. irdadump on the 2.6.18-rt6 side shows only incoming packets
2. sometimes, especially after a connection break down, the connection is 
re-established, but the reference side has empty /proc/net/irda/discovery, 
the reason being a couple of missing packets during re-negotiation:

15:06:43.854376 xid:cmd c62da07d > ffffffff S=6 s=0 (14)
15:06:43.944244 xid:cmd c62da07d > ffffffff S=6 s=1 (14)
15:06:44.034244 xid:cmd c62da07d > ffffffff S=6 s=2 (14)
15:06:44.124245 xid:cmd c62da07d > ffffffff S=6 s=3 (14)
15:06:44.214281 xid:cmd c62da07d > ffffffff S=6 s=4 (14)
15:06:44.304289 xid:cmd c62da07d > ffffffff S=6 s=5 (14)
15:06:44.394282 xid:cmd c62da07d > ffffffff S=6 s=* TESTNODE hint=4400 [ Computer LAN Access ] (25)

15:06:46.864376 xid:cmd c62da07d > ffffffff S=6 s=0 (14)
15:06:46.954286 xid:cmd c62da07d > ffffffff S=6 s=1 (14)
15:06:47.044280 xid:cmd c62da07d > ffffffff S=6 s=2 (14)
15:06:47.134293 xid:cmd c62da07d > ffffffff S=6 s=3 (14)
15:06:47.224281 xid:cmd c62da07d > ffffffff S=6 s=4 (14)
15:06:47.314250 xid:cmd c62da07d > ffffffff S=6 s=5 (14)
15:06:47.404249 xid:cmd c62da07d > ffffffff S=6 s=* TESTNODE hint=4400 [ Computer LAN Access ] (25)

15:06:49.391225 snrm:cmd ca=fe pf=1 c62da07d < 0ad5eb46 new-ca=58 (33)
15:06:49.391389 ua:rsp ca=58 pf=1 c62da07d > 0ad5eb46 (32)
15:06:49.448100 rr:cmd < ca=58 pf=1 nr=0 (2)
15:06:49.448172 rr:rsp > ca=58 pf=1 nr=0 (2)
15:06:49.450636 i:cmd  < ca=58 pf=1 nr=0 ns=0 LM slsap=16 dlsap=00 CONN_CMD (6)
15:06:49.450817 i:rsp  > ca=58 pf=1 nr=1 ns=0 LM slsap=00 dlsap=16 CONN_RSP (6)

I.e., we see 2 discovery packets from TESTNODE, and then the 2.6.18-rt6 
host sends directly an SNRM packet without presenting itself first with 
its nick... Looks like some timers are confused through highres timers?...

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
