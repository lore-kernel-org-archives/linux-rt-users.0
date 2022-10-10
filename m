Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1858DC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Oct 2022 15:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJJPEV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJJPET (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Oct 2022 11:04:19 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B4350FBC
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Oct 2022 08:04:15 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c23so2612090qtw.8
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Oct 2022 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JWFE9GO1Bag9WsyFXWipYKWgtyVlzIwk+tBoF3o9tQw=;
        b=ksSkx8zWx88PNC5zeiJm3633q4T6BhlLpjDt2X16yX3gTFp9PS63Jy9L6TkOBoiRQE
         xBkMvFfOyIDOVqHl/PPAB4zDaff+1SftObkYlNm96OaOPCHvuZPtCyy3RCtsD+N55Aix
         fmus/ghwxxv1ezkcO215G0H8//v3OxC62wIZpE/MGng9l/pKqNnEk8sbu1XfODFBRPiq
         9LMkqqBkSQ7eFOycN0hc3Jf47wCi42sroTLM7qWeV9U9XMMUQa29333OUIhQlVRHZje1
         ZAcwJ+1x1oQvrox4R1nMLCZwucbxO0a05ublSZg4lI6DJcWYYGzNqKDK56vxxJ7tcK3z
         lHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWFE9GO1Bag9WsyFXWipYKWgtyVlzIwk+tBoF3o9tQw=;
        b=IqC6vWdJw+4LVVnIYoAqbf23ukP3CeECALx3Dgj8GyCYLKUH4RqwmlVrNZtW/vVLcr
         HkWXCc3qN3MuNlXMa1nInF304TJiBpD9wMKjfN4zAI/K7XYg4jAOuRxRFmmhitX2RJfB
         Ee54hWCTqFhewS2/8UnfQDl56uIGQLLPhYN0L4EUIfbNNi1cWMD8vhd3b1vLGnRTsnek
         2v2PjRWUddBBq0vYw+RYutcInM3LLKr9e27fXL+OY+3yR3IeJN6K5WECPy1ZWcF6TQHc
         6ep8EwGMvejF+dn8Bo8LjBJjCQhQLbgS8cZ8kklqVwmq8MuDRcf+/C3feFiCF1/S/cOa
         QgNw==
X-Gm-Message-State: ACrzQf1K6n+5oMrN6PIY7cxPaKfKBHhhYyVw22svf//TSJRpy/Is1f4i
        kSuTpwrAo9bvs7ABA/HQC7+8pT48kQs=
X-Google-Smtp-Source: AMsMyM6zYsDW6sMXL/oaZTbbAhGE4GFvhpWJYMaY0dWAFUSguY9w4Hjvd2EutPhBvuJ2CL47Ga44gA==
X-Received: by 2002:ac8:5b51:0:b0:39a:ea24:2c6 with SMTP id n17-20020ac85b51000000b0039aea2402c6mr2505936qtw.490.1665414254131;
        Mon, 10 Oct 2022 08:04:14 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-11-174-88-121-224.dsl.bell.ca. [174.88.121.224])
        by smtp.gmail.com with ESMTPSA id m21-20020a05620a24d500b006cec8001bf4sm10580100qkn.26.2022.10.10.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:04:13 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     Clark Williams <williams@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>
Cc:     Leah Leshchinsky <lleshchi@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        John Kacur <jkacur@redhat.com>
Subject: [RFC PATCH v2] rteval: Replace python-ethtool with inline code
Date:   Mon, 10 Oct 2022 11:03:53 -0400
Message-Id: <20221010150353.131188-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This patch adds the file newnet.py to replace the use of python-ethtool
The information it generates will appear in the summary.xml
You can also test the functionality by running
python rteval/sysinfo/newnet.py

Signed-off-by: John Kacur <jkacur@redhat.com>
- V2 Add SPDX license identifier
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/sysinfo/__init__.py |   3 +-
 rteval/sysinfo/network.py  | 117 -------------------
 rteval/sysinfo/newnet.py   | 225 +++++++++++++++++++++++++++++++++++++
 3 files changed, 227 insertions(+), 118 deletions(-)
 delete mode 100644 rteval/sysinfo/network.py
 create mode 100644 rteval/sysinfo/newnet.py

diff --git a/rteval/sysinfo/__init__.py b/rteval/sysinfo/__init__.py
index a4359382f006..bb1d00810856 100644
--- a/rteval/sysinfo/__init__.py
+++ b/rteval/sysinfo/__init__.py
@@ -32,7 +32,7 @@ from rteval.sysinfo.services import SystemServices
 from rteval.sysinfo.cputopology import CPUtopology
 from rteval.sysinfo.memory import MemoryInfo
 from rteval.sysinfo.osinfo import OSInfo
-from rteval.sysinfo.network import NetworkInfo
+from rteval.sysinfo.newnet import NetworkInfo
 from rteval.sysinfo.cmdline import cmdlineInfo
 from rteval.sysinfo import dmi
 
@@ -46,6 +46,7 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
         CPUtopology.__init__(self)
         OSInfo.__init__(self, logger=logger)
         cmdlineInfo.__init__(self, logger=logger)
+        NetworkInfo.__init__(self, logger=logger)
 
         # Parse initial DMI decoding errors
         dmi.ProcessWarnings()
diff --git a/rteval/sysinfo/network.py b/rteval/sysinfo/network.py
deleted file mode 100644
index ce9989a1240b..000000000000
--- a/rteval/sysinfo/network.py
+++ /dev/null
@@ -1,117 +0,0 @@
-# -*- coding: utf-8 -*-
-#
-#   Copyright 2009 - 2013   David Sommerseth <davids@redhat.com>
-#
-#   This program is free software; you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY; without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#   GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License along
-#   with this program; if not, write to the Free Software Foundation, Inc.,
-#   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-#   For the avoidance of doubt the "preferred form" of this code is one which
-#   is in an open unpatent encumbered format. Where cryptographic key signing
-#   forms part of the process of creating an executable the information
-#   including keys needed to generate an equivalently functional executable
-#   are deemed to be part of the source code.
-#
-
-import ethtool, libxml2
-
-class NetworkInfo(object):
-    def __init__(self):
-        pass
-
-    def net_GetDefaultGW(self):
-        # Get the interface name for the IPv4 default gw
-        route = open('/proc/net/route')
-        defgw4 = None
-        if route:
-            rl = route.readline()
-            while rl != '' :
-                rl = route.readline()
-                splt = rl.split("\t")
-                # Only catch default route
-                if len(splt) > 2 and splt[2] != '00000000' and splt[1] == '00000000':
-                    defgw4 = splt[0]
-                    break
-            route.close()
-        return (defgw4, None) # IPv6 gw not yet implemented
-
-    def MakeReport(self):
-        ncfg_n = libxml2.newNode("NetworkConfig")
-        (defgw4, defgw6) = self.net_GetDefaultGW()
-
-        # Make an interface tag for each device found
-        if hasattr(ethtool, 'get_interfaces_info'):
-            # Using the newer python-ethtool API (version >= 0.4)
-            for dev in ethtool.get_interfaces_info(ethtool.get_devices()):
-                if dev.device == 'lo':
-                    continue
-
-                intf_n = libxml2.newNode('interface')
-                intf_n.newProp('device', dev.device)
-                intf_n.newProp('hwaddr', dev.mac_address)
-                ncfg_n.addChild(intf_n)
-
-                # Protcol configurations
-                if dev.ipv4_address:
-                    ipv4_n = libxml2.newNode('IPv4')
-                    ipv4_n.newProp('ipaddr', dev.ipv4_address)
-                    ipv4_n.newProp('netmask', str(dev.ipv4_netmask))
-                    ipv4_n.newProp('broadcast', dev.ipv4_broadcast)
-                    ipv4_n.newProp('defaultgw', (defgw4 == dev.device) and '1' or '0')
-                    intf_n.addChild(ipv4_n)
-
-                for ip6 in dev.get_ipv6_addresses():
-                    ipv6_n = libxml2.newNode('IPv6')
-                    ipv6_n.newProp('ipaddr', ip6.address)
-                    ipv6_n.newProp('netmask', str(ip6.netmask))
-                    ipv6_n.newProp('scope', ip6.scope)
-                    intf_n.addChild(ipv6_n)
-
-        else: # Fall back to older python-ethtool API (version < 0.4)
-            ifdevs = ethtool.get_active_devices()
-            ifdevs.remove('lo')
-            ifdevs.sort()
-
-            for dev in ifdevs:
-                intf_n = libxml2.newNode('interface')
-                intf_n.newProp('device', dev.device)
-                intf_n.newProp('hwaddr', dev.mac_address)
-                ncfg_n.addChild(intf_n)
-
-                ipv4_n = libxml2.newNode('IPv4')
-                ipv4_n.newProp('ipaddr', ethtool.get_ipaddr(dev))
-                ipv4_n.newProp('netmask', str(ethtool.get_netmask(dev)))
-                ipv4_n.newProp('defaultgw', (defgw4 == dev) and '1' or '0')
-                intf_n.addChild(ipv4_n)
-
-        return ncfg_n
-
-
-def unit_test(rootdir):
-    import sys
-    try:
-        net = NetworkInfo()
-        doc = libxml2.newDoc('1.0')
-        cfg = net.MakeReport()
-        doc.setRootElement(cfg)
-        doc.saveFormatFileEnc('-', 'UTF-8', 1)
-
-    except Exception as e:
-        import traceback
-        traceback.print_exc(file=sys.stdout)
-        print("** EXCEPTION %s", str(e))
-        return 1
-
-if __name__ == '__main__':
-    unit_test(None)
-
diff --git a/rteval/sysinfo/newnet.py b/rteval/sysinfo/newnet.py
new file mode 100644
index 000000000000..63417d9e59f1
--- /dev/null
+++ b/rteval/sysinfo/newnet.py
@@ -0,0 +1,225 @@
+''' Module to obtain network information for the rteval report '''
+#
+#   Copyright 2022 John Kacur <jkacur@redhat.com
+#   SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+import os
+import socket
+import ipaddress
+import sys
+import libxml2
+from rteval.Log import Log
+
+def get_active_devices():
+    ''' returns a list of active network devices, similar to ethtool '''
+    ret = []
+
+    for device in socket.if_nameindex():
+        ret.append(device[1])
+
+    return ret
+
+def compress_iv6(addr):
+    ''' inserts colons into an ipv6address and returns it in compressed form '''
+    retaddr = ''
+    # Insert colons into the number
+    for i in range(4,33,4):
+        if i == 32:
+            retaddr += addr[i-4:i]
+        else:
+            retaddr += addr[i-4:i] + ':'
+    addr = ipaddress.IPv6Network(retaddr)
+    retaddr = str(ipaddress.IPv6Address(retaddr))
+    return retaddr
+
+def get_defaultgw():
+    ''' return the ipv4address of the default gateway '''
+    defaultgw = None
+    with open('/proc/net/route') as f:
+        line = f.readline().strip()
+        while len(line) > 0:
+            (iface, dest, gateway, _, _, _, _, _, _, _, _) = line.split()
+            if iface == 'Iface':
+                line = f.readline().strip()
+                continue
+            if dest == '00000000' and gateway != '00000000':
+                addr = int(gateway, base=16)
+                defaultgw = str(ipaddress.IPv4Address(socket.ntohl(addr)))
+                return defaultgw
+            line = f.readline().strip()
+    return defaultgw
+
+class IPv6Addresses():
+    ''' Obtains a list of IPv6 addresses from the proc file system '''
+
+    def __init__(self):
+        self.data = {}
+        IPv6Addresses.load(self)
+
+    def __contains__(self, dev):
+        return dev in self.data
+
+    def __getitem__(self, dev):
+        return self.data.get(dev, None)
+
+    def __iter__(self):
+        return iter(self.data)
+
+    def load(self):
+        '''
+            Called by init to load the self.data dictionary with device keys
+            and a list of ipv6addresses
+        '''
+        MYP = '/proc/net/if_inet6'
+        with open(MYP, 'r') as f:
+            mystr = f.readline().strip()
+            while len(mystr) > 0:
+                ipv6addr , _, _, _, _, intf = mystr.split()
+                ipv6addr = compress_iv6(ipv6addr)
+                if intf == 'lo':
+                    mystr = f.readline().strip()
+                    continue
+                if intf not in self.data:
+                    self.data[intf] = [ipv6addr]
+                else:
+                    self.data[intf].append(ipv6addr)
+                mystr = f.readline().strip()
+
+class IPv4Addresses():
+    ''' Obtains a list of IPv4 addresses from the proc file system '''
+
+    def __init__(self):
+        self.data = {}
+        IPv4Addresses.load(self)
+
+    def __contains__(self, dev):
+        return dev in self.data
+
+    def __getitem__(self, dev):
+        return self.data[dev]
+
+    def __iter__(self):
+        return iter(self.data)
+
+    def load(self):
+        '''
+            Called by init to load the self.data dictionary with
+            device keys, and value consisting of a list of
+            ipv4address, netmask and broadcast address
+        '''
+        MYP = '/proc/net/route'
+        with open(MYP, 'r') as f:
+            mystr = f.readline().strip()
+            while len(mystr) > 0:
+                intf, dest, _, _, _, _, _, mask, _, _, _ = mystr.split()
+                # Skip over the head of the table an the gateway line
+                if intf == "Iface" or dest == '00000000':
+                    mystr = f.readline().strip()
+                    continue
+                d1 = int(dest, base=16)
+                m1 = int(mask, base=16)
+                addr = str(ipaddress.IPv4Address(socket.ntohl(d1)))
+                netmask = str(ipaddress.IPv4Address(socket.ntohl(m1)))
+                addr_with_mask = ipaddress.ip_network(addr + '/' + netmask)
+                broadcast = str(addr_with_mask.broadcast_address)
+                if intf not in self.data:
+                    self.data[intf] = [(addr, netmask, broadcast)]
+                else:
+                    self.data[intf].append((addr, netmask, broadcast))
+                mystr = f.readline().strip()
+
+
+class MacAddresses():
+    ''' Obtains a list of hardware addresses of network devices '''
+
+    def __init__(self):
+        self.mac_address = {}
+        self.path = None
+        MacAddresses.load(self)
+
+    def load(self):
+        '''
+            called by init to load self.mac_address as a dictionary of
+            device keys, and mac or hardware addresses as values
+        '''
+        nics = get_active_devices()
+        for nic in nics:
+            self.path = f'/sys/class/net/{nic}'
+            hwaddr = MacAddresses.set_val(self, 'address')
+            self.mac_address[nic] = hwaddr
+
+    def set_val(self, val):
+        ''' Return the result of reading self.path/val '''
+        val_path = f'{self.path}/{val}'
+        if os.path.exists(val_path):
+            with open(val_path, 'r') as f:
+                return f.readline().strip()
+        return None
+
+    def __contains__(self, dev):
+        return dev in self.mac_address
+
+    def __getitem__(self, dev):
+        return self.mac_address[dev]
+
+    def __iter__(self):
+        return iter(self.mac_address)
+
+class NetworkInfo():
+    ''' Creates an xml report of the network for rteval '''
+
+    def __init__(self, logger):
+        self.defgw4 = get_defaultgw()
+        self.__logger = logger
+
+    def MakeReport(self):
+        ''' Make an xml report for rteval '''
+        ncfg_n = libxml2.newNode("NetworkConfig")
+        defgw4 = self.defgw4
+
+        mads = MacAddresses()
+        for device in mads:
+            if device == 'lo':
+                continue
+            intf_n = libxml2.newNode('interface')
+            intf_n.newProp('device', device)
+            intf_n.newProp('hwaddr', mads[device])
+            ncfg_n.addChild(intf_n)
+
+            ipv4ads = IPv4Addresses()
+            ipv6ads = IPv6Addresses()
+            for dev in ipv4ads:
+                if dev != device:
+                    continue
+                for lelem in ipv4ads[dev]:
+                    ipv4_n = libxml2.newNode('IPv4')
+                    (ipaddr, netmask, broadcast) = lelem
+                    ipv4_n.newProp('ipaddr', ipaddr)
+                    ipv4_n.newProp('netmask', netmask)
+                    ipv4_n.newProp('broadcast', broadcast)
+                    ipv4_n.newProp('defaultgw', (defgw4 == ipaddr) and '1' or '0')
+                    intf_n.addChild(ipv4_n)
+                if ipv6ads[dev]:
+                    for lelem in ipv6ads[dev]:
+                        ipv6_n = libxml2.newNode('IPv6')
+                        ipaddr = lelem
+                        ipv6_n.newProp('ipaddr', ipaddr)
+                        intf_n.addChild(ipv6_n)
+        return ncfg_n
+
+if __name__ == "__main__":
+
+    try:
+        log = Log()
+        log.SetLogVerbosity(Log.DEBUG|Log.INFO)
+        net = NetworkInfo(logger=log)
+        doc = libxml2.newDoc('1.0')
+        cfg = net.MakeReport()
+        doc.setRootElement(cfg)
+        doc.saveFormatFileEnc('-', 'UTF-8', 1)
+
+    except Exception as e:
+        import traceback
+        traceback.print_exc(file=sys.stdout)
+        print(f"** EXCEPTION {str(e)}")
-- 
2.37.3

