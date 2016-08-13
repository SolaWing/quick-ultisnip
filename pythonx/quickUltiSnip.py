#!/usr/bin/env python
# -*- coding: utf-8 -*-

import re

def translateSnip(text):
    """translate text to a snippet code

    :param str text: aa
    :rtype: str
    """
    count = [0]
    def replaceParam(match):
        count[0] += 1
        return u"${%d:%s}"%(count[0], match.group(0))
    params = re.sub(ur'[^\s,][^,]*', replaceParam, m.group(3))
